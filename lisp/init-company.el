(require-package 'company)
;; Enable the company mode autocompletion for all buffers
(require 'company)
(setq company-idle-delay 0.3)
(add-hook 'after-init-hook 'global-company-mode)

;; Navigate suggestions up and down with C-n and C-p
;; Source: https://github.com/purcell/emacs.d/blob/37532516475d13531dd287d6b11ea4bc03ecfcbc/lisp/init-company.el#L13
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

(provide 'init-company)
