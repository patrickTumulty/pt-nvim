local relative_repos = {}

local function echoerror(msg)
    vim.api.nvim_echo(msg, false, { err = true })
end

local function get_git_branch(repo_path)
    local handle = io.popen("cd '" .. repo_path .. "' && git branch --show-current 2>/dev/null")
    if not handle then
        return "unknown"
    end
    local branch = handle:read("*a")
    handle:close()
    return branch:gsub("%s+", "") or "unknown"
end

local function get_local_repo_paths()
    local uv = vim.uv
    local cwd = vim.fn.getcwd()

    -- Create a pipe for stdout and stderr
    local stdout = uv.new_pipe(false)
    local stderr = uv.new_pipe(false)

    -- Start the background job
    local handle
    handle = uv.spawn("find", {
        args = { cwd, "-name", ".git", "-type", "d" },
        stdio = { nil, stdout, stderr }
    }, function(code, signal)
        if code ~= 0 then
            local msg = "find command failed with code " .. code .. " and signal " .. signal
            echoerror(msg)
        end
        stdout:read_stop()
        stderr:read_stop()
        stdout:close()
        stderr:close()
        handle:close()
    end)

    -- Read the stdout and process the paths
    local i = 1
    uv.read_start(stdout, function(err, data)
        if err then
            echoerror(err)
            return
        end
        if not data then
            return
        end

        for repo_path in data:gmatch("[^\r\n]+") do
            local repo_dirname = string.match(repo_path, "/([^/]+)/.git$")
            local clean_path = string.gsub(repo_path, "%.git$", "")
            local branch = get_git_branch(clean_path)
            relative_repos[i] = {
                dirname = repo_dirname,
                path = clean_path,
                branch = branch
            }
            i = i + 1
        end
    end)

    -- Read the stderr and print any errors
    uv.read_start(stderr, function(err, data)
        if err then
            err(err)
            vim.notify(err, vim.log.levels.ERROR)
        end
    end)
end

get_local_repo_paths()

local function show_repos(repos)
    local actions = require('telescope.actions')
    local finders = require('telescope.finders')
    local config = require('telescope.config')

    local opts = {
        prompt_title = "Choose an Option",
        finder = finders.new_table({
            results = repos,
            entry_maker = function(entry)
                local current_branch = get_git_branch(entry.path)
                return {
                    value = entry.path,      -- Action to be performed
                    display = entry.dirname .. " (" .. current_branch .. ")", -- The text shown in the UI
                    ordinal = entry.dirname  -- Sort/Filter by this value
                }
            end
        }),
        sorter = config.values.generic_sorter({}),
        layout_config = {
            width = 0.4,
            height = 0.3,
        },
        attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                actions.close(prompt_bufnr)
                vim.cmd("Neogit cwd=" .. selection.value)
            end)
            return true
        end
    }

    require('telescope.pickers').new({}, opts):find()
end

vim.keymap.set("n", "<leader>gg", function()
    local length = #relative_repos
    if length <= 1 then
        vim.cmd("Neogit")
    else
        show_repos(relative_repos)
    end
end, { desc = "Neogit: [G]it" })
