;; Clojure configuration
;;
;; Copied from https://github.com/ovan/.emacs.d

(require-package 'clojure-mode)
(require-package 'cider '(20180723 2337))
(require-package 'cider-eval-sexp-fu)
(require-package 'align-cljlet)

;; clj-kondo
;;
;; For some reason, I just couldn't get this working by using
;; require-package. Copy-pasted from
;; https://github.com/borkdude/flycheck-clj-kondo/blob/5472c26ffdf754a0661357564874ffd4f8598805/flycheck-clj-kondo.el
;; and now it seems to work..?
(defmacro flycheck-clj-kondo--define-checker
    (name lang mode &rest extra-args)
  "Internal macro to define checker.
Argument NAME: the name of the checker.
Argument LANG: language string.
Argument MODE: the mode in which this checker is activated.
Argument EXTRA-ARGS: passes extra args to the checker."
  (let ((command
         (append
          (list "clj-kondo" "--lint" "-" "--lang" lang)
          extra-args)))
    `(flycheck-define-checker ,name
       "See https://github.com/borkdude/clj-kondo"
       :command ,command
       :standard-input t
       :error-patterns
       ((error line-start "<stdin>:" line ":" column ": " (0+ not-newline) (or "error: " "Exception: ") (message) line-end)
        (warning line-start "<stdin>:" line ":" column ": " (0+ not-newline) "warning: " (message) line-end)
        (info line-start "<stdin>:" line ":" column ": " (0+ not-newline) "info: " (message) line-end))
       :modes (,mode)
       :predicate (lambda ()
                    (if buffer-file-name
                        ;; If there is an associated file with buffer, use file name extension
                        ;; to infer which language to turn on.
                        (string= ,lang (file-name-extension buffer-file-name))
                      ;; Else use the mode to infer which language to turn on.
                      ,(pcase lang
                         ("clj" `(equal 'clojure-mode major-mode))
                         ("cljs" `(equal 'clojurescript-mode major-mode))
                         ("cljc" `(equal 'clojurec-mode major-mode))))))))

(defmacro flycheck-clj-kondo-define-checkers (&rest extra-args)
  "Defines all clj-kondo checkers.
Argument EXTRA-ARGS: passes extra arguments to the checkers."
  `(progn
     (flycheck-clj-kondo--define-checker clj-kondo-clj "clj" clojure-mode ,@extra-args)
     (flycheck-clj-kondo--define-checker clj-kondo-cljs "cljs" clojurescript-mode ,@extra-args)
     (flycheck-clj-kondo--define-checker clj-kondo-cljc "cljc" clojurec-mode ,@extra-args)
     (flycheck-clj-kondo--define-checker clj-kondo-edn "edn" clojure-mode ,@extra-args)
     (dolist (element '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))
       (add-to-list 'flycheck-checkers element))))

(flycheck-clj-kondo-define-checkers "--cache")

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
  (my-clojure/do-with-append 'cider-eval-last-sexp)
  ;; (with-current-buffer (cider-current-repl-buffer)
  ;;   (goto-char (point-max))
  ;;   (when (eq 'cljs (cider-repl-type-for-buffer))
  ;;     (insert "(sharetribe.console.ui.figwheel-entry/on-jsload)")
  ;;     (message "reagent rerendered"))
  ;;   (cider-repl-return))
  )

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
;;; init-clojure.el ends here
