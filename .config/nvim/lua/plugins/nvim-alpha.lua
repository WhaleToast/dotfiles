return {
    'goolord/alpha-nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function ()
        -- Header Option 1: The Classic Procrastination
        local header_procrastination = {
            "                                                     ",
            "  ╔══════════════════════════════════════════════╗  ",
            "  ║                                              ║  ",
            "  ║           TIME TO BE PRODUCTIVE!             ║  ",
            "  ║                                              ║  ",
            "  ║         (after I configure this editor       ║  ",
            "  ║            for the 47th time today)          ║  ",
            "  ║                                              ║  ",
            "  ╚══════════════════════════════════════════════╝  ",
            "                                                     ",
        }

        -- Header Option 2: Vim vs Emacs Peace Treaty
        local header_peace_treaty = {
            "                                                     ",
            "  ░█▀█░█▀▀░█▀█░█░█░▀█▀░█▄█                          ",
            "  ░█░█░█▀▀░█░█░▀▄▀░░█░░█░█                          ",
            "  ░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀                          ",
            "                                                     ",
            "        \"I'm not like other editors...              ",
            "         I'm a ✨ MODAL ✨ editor\"                  ",
            "                                                     ",
        }

        -- Header Option 3: The Honest Truth
        local header_honest = {
            "                                                     ",
            "  ███╗   ██╗ ██████╗      ██╗    ██╗██╗  ██╗██╗   ██╗",
            "  ████╗  ██║██╔═══██╗     ██║    ██║██║  ██║██║   ██║",
            "  ██╔██╗ ██║██║   ██║     ██║ █╗ ██║███████║╚██╗ ██╔╝",
            "  ██║╚██╗██║██║   ██║     ██║███╗██║██╔══██║ ╚████╔╝ ",
            "  ██║ ╚████║╚██████╔╝     ╚███╔███╔╝██║  ██║  ╚██╔╝  ",
            "  ╚═╝  ╚═══╝ ╚═════╝       ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝   ",
            "                                                     ",
            "         \"No, I still don't know how to exit\"      ",
            "                                                     ",
        }

        -- Header Option 4: Productivity Warning
        local header_productivity = {
            "                                                     ",
            "  ⚠️  WARNING: ENTERING PRODUCTIVITY ZONE  ⚠️       ",
            "                                                     ",
            "     Side effects may include:                       ",
            "     • Spending 3 hours configuring colorschemes    ",
            "     • Installing 47 plugins you'll never use       ",
            "     • Forgetting what you originally came here to do",
            "     • Achieving enlightenment through key bindings  ",
            "                                                     ",
            "              Press any key to continue...           ",
            "          (but make sure it's the right key)         ",
            "                                                     ",
        }

        -- Header Option 5: The Relationship Status
        local header_relationship = {
            "                                                     ",
            "  ┌─────────────────────────────────────────────┐   ",
            "  │                                             │   ",
            "  │  Relationship Status: It's Complicated      │   ",
            "  │                                             │   ",
            "  │  Me: I love you, Neovim                     │   ",
            "  │  Neovim: E37: No write since last change    │   ",
            "  │  Me: 😢                                     │   ",
            "  │  Neovim: (add ! to override)                │   ",
            "  │  Me: I LOVE YOU, NEOVIM!                    │   ",
            "  │  Neovim: ❤️                                │   ",
            "  │                                             │   ",
            "  └─────────────────────────────────────────────┘   ",
            "                                                     ",
        }
        local dashboard = require("alpha.themes.dashboard")
        require'alpha'.setup(require'alpha.themes.dashboard'.config)

        -- set header
        dashboard.section.header.val = header_honest

        -- set menu 
        dashboard.section.buttons.val = {
        dashboard.button( "e", "> New file" , ":ene <BAR> startinsert <CR>"),
        dashboard.button( "r", "> Recent"   , ":Telescope oldfiles<CR>"),
        dashboard.button("f", "> Find file", ":lua require('telescope.builtin').find_files({hidden = true, file_ignore_patterns = {'node_modules', '.git', '.cache', '.local', 'Downloads', 'Pictures', 'Videos', 'Music', 'Games', 'Zomboid', '%.dotfiles', 'Calibre Library', 'Nextcloud', '.electrum', '.runelite', '.wine', '.asdf', '.cargo', '%.pg', '%.png', '%.mp4', '%.mp3', '.oh%-my%-zsh', '.config/gtk%-3.0', '.go', '.config/kate'}})<CR>"),
        dashboard.button( "s", "> Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
        dashboard.button( "q", "> Quit NVIM", ":qa<CR>"),
}

    end
}
