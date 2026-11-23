-- Ordered most specific first: the first matching entry wins, so main.cpp must precede *.cpp.
local template_info_list = {
    { ext = "main.cpp",       glob = "main.cpp",       pattern = "^main%.cpp$" },
    { ext = "main.c",         glob = "main.c",         pattern = "^main%.c$" },
    { ext = "CMakeLists.txt", glob = "CMakeLists.txt", pattern = "^CMakeLists%.txt$" },
    { ext = "sh",             glob = "*.sh",           pattern = "%.sh$" },
    { ext = "html",           glob = "*.html",         pattern = "%.html$" },
    { ext = "hpp",            glob = "*.hpp",          pattern = "%.hpp$" },
    { ext = "h",              glob = "*.h",            pattern = "%.h$" },
    { ext = "cpp",            glob = "*.cpp",          pattern = "%.cpp$" },
    { ext = "c",              glob = "*.c",            pattern = "%.c$" },
}

local config_path = vim.fn.stdpath("config")

local template_group = vim.api.nvim_create_augroup("template", { clear = true })

local function read_lines_from_file(filepath)
    local lines = {}
    local file = io.open(filepath, "r")

    if file then
        for line in file:lines() do
            table.insert(lines, line)
        end
        file:close()
    else
        print("Failed to open file: " .. filepath)
    end

    return lines
end

local function to_snake(str, upper)
    str = str:gsub("([a-z])([A-Z])", "%1_%2")
    if upper then
        return str:upper()
    else
        return str:lower()
    end
end

local function to_camel(str)
    str = str:gsub("_", " ")
    str = str:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest
    end)
    str = str:gsub(" ", "")
    return str
end

local function process_template_lines(buf_name, lines)
    -- Function replacements so a '%' in the filename isn't treated as a capture reference
    local replacements = {
        ["${FILE_NAME}"] = function() return to_snake(buf_name, true) end,
        ["${file_name}"] = function() return to_snake(buf_name, false) end,
        ["${FileName}"] = function() return to_camel(buf_name) end,
        ["${filename}"] = function() return buf_name end,
    }
    for i, line in ipairs(lines) do
        for placeholder, replacement in pairs(replacements) do
            line = line:gsub(vim.pesc(placeholder), replacement)
        end
        lines[i] = line
    end
    return lines
end

local function file_stem(path, extension)
    local stem = vim.fs.basename(path):gsub("%." .. vim.pesc(extension) .. "$", "")
    return stem
end

local function write_skeleton_file_to_buffer(filepath, extension)
    local buf_name = file_stem(vim.api.nvim_buf_get_name(0), extension)
    local lines = read_lines_from_file(filepath)
    lines = process_template_lines(buf_name, lines)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

local function write_skeleton_file_to_file(template_path, filepath, extension)
    local buf_name = file_stem(filepath, extension)
    local lines = read_lines_from_file(template_path)
    lines = process_template_lines(buf_name, lines)
    local file = io.open(filepath, "w")
    if file == nil then
        vim.print("Unable to open file")
        return
    end
    for _, line in ipairs(lines) do
        file:write(line .. "\n")
    end
    file:close()
end

local function skeleton_path(template_info)
    return config_path .. utils.sep .. "templates" .. utils.sep .. "template." .. template_info.ext .. ".skel"
end

local function find_template(filename)
    for _, template_info in ipairs(template_info_list) do
        if filename:match(template_info.pattern) and utils.file_exists(skeleton_path(template_info)) then
            return template_info
        end
    end
end

vim.api.nvim_create_autocmd("BufNewFile", {
    pattern = vim.tbl_map(function(template_info) return template_info.glob end, template_info_list),
    group = template_group,
    callback = function(args)
        local template_info = find_template(vim.fs.basename(args.file))
        if template_info then
            write_skeleton_file_to_buffer(skeleton_path(template_info), template_info.ext)
        end
    end
})

vim.api.nvim_create_autocmd("User", {
    pattern = "OilActionsPost",
    callback = function(args)
        if args.data.err ~= nil then
            return
        end

        for _, action in ipairs(args.data.actions) do
            if action.type ~= "create" then
                goto continue
            end
            local path = action.url
            -- Handle oil:// protocol cross-platform
            if utils.is_windows() then
                path = path:gsub("oil://", "")
                path = path:gsub("/", "\\")
            else
                path = path:gsub("oil:///", "/")
            end
            local filename = path:match("([^/\\]+)$")

            local template_info = find_template(filename)
            if template_info then
                write_skeleton_file_to_file(skeleton_path(template_info), path, template_info.ext)
            end

            ::continue::
        end
    end,
})
