;; Parinfer
;; https://github.com/DogLooksGood/parinfer-mode/

(require-package 'parinfer)

(setq parinfer-extensions
          '(defaults       ; should be included.
            pretty-parens  ; different paren styles for different modes.
            evil           ; If you use Evil.
            paredit        ; Introduce some paredit commands.
            smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
            smart-yank))   ; Yank behavior depend on mode.

(add-hook 'clojure-mode-hook #'parinfer-mode)

(provide 'init-parinfer)
