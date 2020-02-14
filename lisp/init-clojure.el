;; Clojure configuration
;;
;; Copied from https://github.com/ovan/.emacs.d

(require-package 'clojure-mode)
(require-package 'cider '(20180723 2337))
(require-package 'cider-eval-sexp-fu)
(require-package 'align-cljlet)

;; Add helm-cider
;; https://github.com/clojure-emacs/helm-cider
;;
(require-package 'helm-cider)
(helm-cider-mode 1)

;; Enable eval'd expression highlighting
;; FIXME cider-eval-sexp-fu doesn't work, after several hours of debugging.
;; The error I get is that Symbol is void
;; (require 'cider-eval-sexp-fu)

;; Not spending time to learn to use this right now but maybe one day...
(require-package 'clj-refactor)

(add-hook 'cider-mode-hook 'eldoc-mode)

(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook 'smartparens-strict-mode)
(add-hook 'clojure-mode-hook 'show-smartparens-mode)
(add-hook 'clojure-mode-hook #'evil-smartparens-mode)

(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

;; Define versions of typical cider-eval-last-x functions to work with
;; evil's normal mode where point is one char left from where it would
;; be in insert mode.

(defun my-clojure/do-with-append (EVAL-FUNC &optional ARGS)
  (let ((args (if (null ARGS) nil ARGS)))
    (cond
     ((evil-normal-state-p)
      (evil-append 1)
      (apply EVAL-FUNC args)
      (evil-normal-state)))))

(defun my-clojure/eval-last-sexp ()
  (interactive)
  (my-clojure/do-with-append 'cider-eval-last-sexp))

(defun my-clojure/pprint-eval-last-sexp ()
  (interactive)
  (my-clojure/do-with-append 'cider-pprint-eval-last-sexp))

(defun my-clojure/eval-last-sexp-to-repl ()
  (interactive)
  (my-clojure/do-with-append 'cider-eval-last-sexp-to-repl))

;; This has a bug that leaves sending buffer to insert mode
(defun my-clojure/insert-last-sexp-in-repl ()
  (interactive)
  (my-clojure/do-with-append 'cider-insert-last-sexp-in-repl))

(defun my-clojure/eval-last-sexp-and-replace ()
  (interactive)
  (my-clojure/do-with-append 'cider-eval-last-sexp-and-replace))

;; Adapted from https://github.com/syl20bnr/spacemacs/commit/4a0abb18cc37e5311db6338872bd9a49fa96dc36
(defun my-clojure/cider-debug-setup ()
  (evil-make-overriding-map cider--debug-mode-map 'normal)
  (evil-normalize-keymaps))

(add-hook 'cider--debug-mode-hook 'my-clojure/cider-debug-setup)

(add-hook 'cider-mode-hook
          (lambda ()
            (define-key cider-mode-map (kbd "C-c C-e") 'my-clojure/eval-last-sexp)
            (define-key cider-mode-map (kbd "C-c C-p") 'my-clojure/pprint-eval-last-sexp)
            (define-key cider-mode-map (kbd "C-c M-e") 'my-clojure/eval-last-sexp-to-repl)
            (define-key cider-mode-map (kbd "C-c M-p") 'my-clojure/insert-last-sexp-in-repl)
            (define-key cider-mode-map (kbd "C-c C-w") 'my-clojure/eval-last-sexp-and-replace)))

;; Adapted from:
;; https://github.com/stuartsierra/dotfiles/blob/d0d1c46ccc4fdd8d2add363615e625cc29d035b0/.emacs#L307-L312
(defun my-clojure/cider-reset ()
  (interactive)
  (cider-ensure-connected)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(user/reset)")
    (cider-repl-return))
  (message "(user/reset) called"))

;; Some leader bindings for clojure-mode / cider commands
(evil-leader/set-key-for-mode 'clojure-mode
  "r"  'my-clojure/cider-reset)

;; Rebind M-. back to 'robe-jump instead of evil mode repeat
(evil-define-key 'normal cider-mode-map (kbd "M-.") 'cider-find-var)

;; Clojure script
;; (setq cider-cljs-lein-repl
;;       "(do (require 'figwheel-sidecar.repl-api)
;;            (figwheel-sidecar.repl-api/start-figwheel!)
;;            (figwheel-sidecar.repl-api/cljs-repl))")

(setq cljr-favor-prefix-notation nil)

;; Set default cljs repl
;; It's probably bad idea to set this
;; globally. Instead, this should be set via .dir-locals
;; (setq cider-default-cljs-repl 'figwheel)

(provide 'init-clojure)
