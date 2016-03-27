(require-package 'js2-mode)
(require-package 'web-mode)

(setq-default
 js2-basic-offset 2
 js2-bounce-indent-p nil)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))

(setq web-mode-enable-current-column-highlight t)

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

(provide 'init-web)
