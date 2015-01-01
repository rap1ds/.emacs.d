(require-package 'rainbow-delimiters)

(global-linum-mode 1)

;; Enable in all programming related modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(provide 'init-global-modes)
