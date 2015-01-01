(require-package 'smartparens)

(require 'smartparens-config)

(smartparens-global-mode 1)

; evilish slurp and barf keybindings
(define-key sp-keymap (kbd "C-l") 'sp-forward-slurp-sexp)
(define-key sp-keymap (kbd "C-h") 'sp-forward-barf-sexp)
(define-key sp-keymap (kbd "C-M-h") 'sp-backward-slurp-sexp)
(define-key sp-keymap (kbd "C-M-l") 'sp-backward-barf-sexp)

(provide 'init-smartparens)
