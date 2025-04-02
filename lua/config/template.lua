local file_extensions = {
    "sh",
    "html",
    "h",
    "hpp",
    "c",
    "cpp",
}

local function file_exists(filepath)
    local f = io.open(filepath, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end


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

local function toSnake(str, upper)
    str = str:gsub("([a-z])([A-Z])", "%1_%2")
    if upper then
        return str:upper()
    else
        return str:lower()
    end
end

local function toCamel(str)
    str = str:gsub("_", " ")
    str = str:gsub("(%a)([%w_']*)", function(first, rest)
        return first:upper() .. rest
    end)
    str = str:gsub(" ", "")
    return str
end

local function write_skeleton_file_to_buffer(filepath, extension)
    local lines = read_lines_from_file(filepath)
    local buf = vim.api.nvim_get_current_buf()
    local buf_name = vim.api.nvim_buf_get_name(buf)
    buf_name = buf_name:match(".*/(.*)%." .. extension .. "$")
    for i, line in ipairs(lines) do
        if contains_substring(line, "${FILE_NAME}") then
            -- Upper snake case filename
            lines[i] = line:gsub("${FILE_NAME}", toSnake(buf_name, true))
        elseif contains_substring(line, "${file_name}") then
            -- Lower snake case filename
            lines[i] = line:gsub("${file_name}", toSnake(buf_name, false))
        elseif contains_substring(line, "${FileName}") then
            -- Camel case filename
            lines[i] = line:gsub("${FileName}", toCamel(buf_name))
        elseif contains_substring(line, "${filename}") then
            -- No formatting on filename
            lines[i] = line:gsub("${filename}", buf_name)
        end
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

for _, extension in ipairs(file_extensions) do
    local skeleton_file_path = config_path .. "/templates/template." .. extension .. ".skel"
    if file_exists(skeleton_file_path) then
        vim.api.nvim_create_autocmd("BufNewFile", {
            pattern = "*." .. extension,
            group = template_group,
            callback = function()
                write_skeleton_file_to_buffer(skeleton_file_path, extension)
            end
        })
    end
end
