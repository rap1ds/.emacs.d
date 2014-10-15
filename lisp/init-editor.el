(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

(global-hl-line-mode 1)
(set-default 'cursor-type 'bar)

;; Unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(provide 'init-editor)
