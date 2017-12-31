(require-package 'helm)

(require 'helm-config)

;; Copied from
;; https://github.com/ovan/.emacs.d/

;; Bind helm version of M-x
(global-set-key (kbd "M-x") 'helm-M-x)

;; Helm version of find files
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; Enable helm mode
(helm-mode 1)

;; (define-key global-map [remap occur] 'helm-occur)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
;; (define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
;; (define-key global-map [remap execute-extended-command] 'helm-M-x)

;; (unless (boundp 'completion-in-region-function)
;;   (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
;;   (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

;; Always show helm window at the bottom
;; https://www.reddit.com/r/emacs/comments/345vtl/make_helm_window_at_the_bottom_without_using_any/
(add-to-list 'display-buffer-alist
             `(,(rx bos "*helm" (* not-newline) "*" eos)
               (display-buffer-in-side-window)
               (inhibit-same-window . t)
               (window-height . 0.4)))

(provide 'init-helm)
