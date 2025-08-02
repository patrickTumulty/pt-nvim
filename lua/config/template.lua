local template_info_list = {
    { ext = "sh",             pattern = "%.sh$" },
    { ext = "html",           pattern = "%.html$" },
    { ext = "hpp",            pattern = "%.hpp$" },
    { ext = "h",              pattern = "%.h$" },
    { ext = "cpp",            pattern = "%.cpp$" },
    { ext = "c",              pattern = "%.c$" },
    { ext = "CMakeLists.txt", pattern = "CMakeLists.txt$" },
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

local function contains_substring(str, substr)
    local start_pos, _ = string.find(str, substr)
    return start_pos ~= nil
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
    for i, line in ipairs(lines) do
        if contains_substring(line, "${FILE_NAME}") then
            -- Upper snake case filename
            lines[i] = line:gsub("${FILE_NAME}", to_snake(buf_name, true))
        elseif contains_substring(line, "${file_name}") then
            -- Lower snake case filename
            lines[i] = line:gsub("${file_name}", to_snake(buf_name, false))
        elseif contains_substring(line, "${FileName}") then
            -- Camel case filename
            lines[i] = line:gsub("${FileName}", to_camel(buf_name))
        elseif contains_substring(line, "${filename}") then
            -- No formatting on filename
            lines[i] = line:gsub("${filename}", buf_name)
        end
    end
    return lines
end

local function write_skeleton_file_to_buffer(filepath, extension)
    local buf = vim.api.nvim_get_current_buf()
    local buf_name = vim.api.nvim_buf_get_name(buf)
    buf_name = buf_name:match(".*/(.*)%." .. extension .. "$")
    local lines = read_lines_from_file(filepath)
    lines = process_template_lines(buf_name, lines)
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

local function write_skeleton_file_to_file(template_path, filepath, extension)
    local buf_name = filepath:match(".*/(.*)%." .. extension .. "$")
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

for _, extension in ipairs(template_info_list) do
    local skeleton_file_path = config_path .. "/templates/template." .. extension.ext .. ".skel"
    if utils.file_exists(skeleton_file_path) then
        vim.api.nvim_create_autocmd("BufNewFile", {
            pattern = "*." .. extension.ext,
            group = template_group,
            callback = function()
                write_skeleton_file_to_buffer(skeleton_file_path, extension.ext)
            end
        })
    end
end

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
            path = path:gsub("oil:///", "/")
            local filename = path:match("([^/\\]+)$")

            for _, template_info in ipairs(template_info_list) do
                if not filename:match(template_info.pattern) then
                    goto continue2
                end
                local skeleton_file_path = config_path .. "/templates/template." .. template_info.ext .. ".skel"
                if not utils.file_exists(skeleton_file_path) then
                    goto continue2
                end
                write_skeleton_file_to_file(skeleton_file_path, path, template_info.ext)
                ::continue2::
            end

            ::continue::
        end
    end,
})
