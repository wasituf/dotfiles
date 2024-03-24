return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    local api = require("nvim-tree.api")

    local git_add = function()
      local node = api.tree.get_node_under_cursor()
      local gs = node.git_status.file

      -- If the current node is a directory get children status
      if gs == nil then
        gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1]) 
        or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
      end

      -- If the file is untracked, unstaged or partially staged, we stage it
      if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
        vim.cmd("silent !git add " .. node.absolute_path)

        -- If the file is staged, we unstage
      elseif gs == "M " or gs == "A " then
        vim.cmd("silent !git restore --staged " .. node.absolute_path)
      end
      api.tree.reload()
    end

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local function my_on_attach(bufnr) 
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
      vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
      vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
      vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
      vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
      vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
      vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
      vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
      vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
      vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
      vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
      vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
      vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
      vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
      vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
      vim.keymap.set('n', 'bd',    api.marks.bulk.delete,                 opts('Delete Bookmarked'))
      vim.keymap.set('n', 'bt',    api.marks.bulk.trash,                  opts('Trash Bookmarked'))
      vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
      vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle Filter: No Buffer'))
      vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
      vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Filter: Git Clean'))
      vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
      vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
      vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
      vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
      vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
      vim.keymap.set('n', '<leader>e',     api.fs.rename_basename,                opts('Rename: Basename'))
      vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
      vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
      vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
      vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
      vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
      vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
      vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Filter: Dotfiles'))
      vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Filter: Git Ignore'))
      vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
      vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
      vim.keymap.set('n', '<leader>m',     api.marks.toggle,                      opts('Toggle Bookmark'))
      vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
      vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
      vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
      vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
      vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
      vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
      vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
      vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
      vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
      vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Filter: Hidden'))
      vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
      vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
      vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
      vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
      vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
      vim.keymap.set('n', '<leader>/', api.tree.change_root_to_node, opts('CD'))

      vim.keymap.set("n", "<leader>p.", "<cmd>NvimTreeToggle<CR>")


      vim.keymap.set("n", "m", "h", { noremap = true })
      vim.keymap.set("n", "n", "j", { noremap = true })
      vim.keymap.set("n", "e", "k", { noremap = true })
      vim.keymap.set("n", "i", "l", { noremap = true })

      vim.keymap.set("n", "M", "H", { noremap = true })
      vim.keymap.set("n", "N", "L", { noremap = true })
      vim.keymap.set("n", "E", "K", { noremap = true })
      vim.keymap.set("n", "I", "L", { noremap = true })

      vim.keymap.set("n", "h", "i", { noremap = true })
      vim.keymap.set("n", "k", "n", { noremap = true })
      vim.keymap.set("n", "j", "e", { noremap = true })
      vim.keymap.set("n", "l", "m", { noremap = true })

      -- Git
      vim.keymap.set("n", "ga", git_add, opts("Git add"))
    end

    local HEIGHT_RATIO = 0.8
    local WIDTH_RATIO = 0.65

    nvimtree.setup({
      on_attach = my_on_attach,
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2)
            - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      renderer = {
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "",
              arrow_open = "",
            },
          },
        },
      },
      filters = {
        dotfiles = true,
        custom = {},
        exclude = { 'node_modules' },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
          quit_on_open = true,
        },
      },
    })
  end,
}
