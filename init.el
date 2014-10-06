;; init.el

;; Package managers

(require 'package)
(setq package-archives
      '(("marmalade" . "http://marmalade-repo.org/packages/")
        ;; ("tromey" . "http://tromey.com/elpa/")
    ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; My installed packages

(defvar my-packages '(color-theme-solarized))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

;; Theme

(load-theme 'solarized-dark t)
