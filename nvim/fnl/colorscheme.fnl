(local get-system-mode (fn []
                        (match (io.open (.. (os.getenv "HOME") "/.config/system-theme"))
                          f (do (local mode (f:read))
                              (f:close)
                              mode)
                          (nil err-msg) (print "Could not open file:" err-msg))))
(local get-editor-mode (fn [] (vim.api.nvim_get_option "background")))
(local toggle-mode (lambda [mode] (if (= mode :dark) :light :dark)))

(local reset-statusline (fn []
                         (set package.loaded.statusline nil)
                         (require "statusline")))

;; also config
(local colorschemes {
       :dark ["kuroi" "kanagawa-dragon" "night-owl" "oxocarbon-lua"]
       :light ["quietlight" "catppuccin-latte"]
       })
(local colorscheme-mode-config { :dark 2 :light 2 })

(lambda set-colorscheme [mode idx]
  (local colorscheme (. (. colorschemes mode) (tonumber idx)))
  (vim.cmd (.. "set background=" mode))
  (vim.cmd (.. "colorscheme " colorscheme))
  (reset-statusline))

(lambda set-colorscheme-by-mode [colorscheme-idx]
  (local mode (get-system-mode))
  (set-colorscheme mode colorscheme-idx))

(fn set-colorscheme-mode [?mode]
  (local mode (if (or (= ?mode nil) (= (length ?mode) 0)) (toggle-mode (get-editor-mode)) ?mode))
  (set-colorscheme mode (. colorscheme-mode-config mode))
  )

;; commands
(vim.api.nvim_create_user_command "SetColorschemeByMode" (fn [opts] (set-colorscheme-by-mode opts.args)) {:nargs 1})
(vim.api.nvim_create_user_command "SetColorschemeMode" (fn [opts] (set-colorscheme-mode opts.args)) {:nargs "?"})

;; config
(set-colorscheme-by-mode 1)
