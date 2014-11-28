(require-package 'rainbow-delimiters)
(require-package 'smartparens)

(global-linum-mode 1)

;; Enable in all programming related modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(smartparens-global-mode 1)

(provide 'init-global-modes)
