(require-package 'scss-mode)
(require-package 'rainbow-mode)

(setq scss-compile-at-save nil)

(add-hook 'scss-mode-hook 'rainbow-mode)

(provide 'init-sass)
