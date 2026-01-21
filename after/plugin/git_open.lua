local function get_repos()
    local repos = {}
    local cwd = vim.fn.getcwd()

    -- 1. Find standard git repos (searching for .git folders)
    -- Use -maxdepth if you want to limit how deep the search goes
    local find_cmd = { "find", cwd, "-path", "*/.git/config" }
    local find_out = vim.system(find_cmd, { text = true }):wait()

    if find_out.code == 0 then
        for line in find_out.stdout:gmatch("[^\r\n]+") do
            local path = vim.fn.fnamemodify(line, ":p:h:h") -- Get the parent of .git
            local name = vim.fn.fnamemodify(path, ":t")

            -- Get branch efficiently
            local branch_out = vim.system({ "git", "-C", path, "branch", "--show-current" }, { text = true }):wait()
            local branch = (branch_out.stdout or "unknown"):gsub("%s+", "")

            table.insert(repos, {
                dirname = name,
                path = path,
                branch = branch,
                submodule = false
            })
        end
    end

    -- 2. Find Submodules
    local sub_cmd = { "git", "submodule", "foreach", "--quiet", [[echo "$displaypath|$(pwd)"]] }
    local sub_out = vim.system(sub_cmd, { text = true }):wait()

    if sub_out.code == 0 then
        for line in sub_out.stdout:gmatch("[^\r\n]+") do
            local rel, abs = line:match("([^|]+)|([^|]+)")
            if rel and abs then
                -- Get branch/tag for submodule
                local branch_out = vim.system({ "git", "-C", abs, "rev-parse", "--abbrev-ref", "HEAD" }, { text = true })
                    :wait()
                local branch = (branch_out.stdout or "head"):gsub("%s+", "")
                local tag_out = vim.system({ "git", "-C", abs, "describe", "--tag", "--always" }, { text = true }):wait()
                local tag = (tag_out.stdout or ""):gsub("%s+", "")

                table.insert(repos, {
                    dirname = "[Sub] " .. rel,
                    path = abs,
                    branch = branch .. " | " .. tag,
                    submodule = true
                })
            end
        end
    end

    return repos
end

local function show_repo_picker()
    local repos = get_repos()

    if #repos == 0 then
        vim.cmd("Neogit")
        return
    end

    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local conf = require('telescope.config').values

    pickers.new({}, {
        prompt_title = "Select Repository",
        finder = finders.new_table({
            results = repos,
            entry_maker = function(entry)
                return {
                    value = entry.path,
                    display = string.format("%-20s  %s", entry.dirname, entry.branch),
                    ordinal = entry.dirname,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        layout_config = {
            width = 0.4,
            height = 0.3,
        },
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                vim.cmd("Neogit cwd=" .. selection.value)
            end)
            return true
        end,
    }):find()
end

vim.keymap.set("n", "<leader>gg", show_repo_picker, { desc = "Neogit: Select Repo" })

