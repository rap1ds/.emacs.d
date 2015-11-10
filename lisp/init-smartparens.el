(require-package 'smartparens)

(require 'smartparens-config)
(require-package 'evil-smartparens)

(smartparens-global-mode 1)

(sp-use-paredit-bindings)

;; evilish slurp and barf keybindings

;; This wasn't that good idea, since it overrides C-h, which is pretty
;; important

;; (define-key sp-keymap (kbd "C-l") 'sp-forward-slurp-sexp)
;; (define-key sp-keymap (kbd "C-h") 'sp-forward-barf-sexp)
;; (define-key sp-keymap (kbd "C-M-h") 'sp-backward-slurp-sexp)
;; (define-key sp-keymap (kbd "C-M-l") 'sp-backward-barf-sexp)

(defface sp-pair-overlay-face
  '((t (:inherit highlight)))
  "The face used to highlight pair overlays."
  :group 'smartparens)

(defface sp-wrap-overlay-face
  '((t (:inherit sp-pair-overlay-face)))
  "The face used to highlight wrap overlays."
  :group 'smartparens)

(defface sp-wrap-tag-overlay-face
  '((t (:inherit sp-pair-overlay-face)))
  "The face used to highlight wrap tag overlays."
  :group 'smartparens)

(provide 'init-smartparens)
