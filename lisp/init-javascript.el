(require-package 'js2-mode)

(setq-default
 js2-basic-offset 2
 js2-bounce-indent-p nil)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(provide 'init-javascript)
