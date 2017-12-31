;;;
;;; My emacs configurations
;;;
;;; Copied from: https://github.com/purcell/emacs.d/blob/master/init.el
;;;


;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-elpa) ;; Machinery for installing required packages
(require 'init-themes)
(require 'init-osx)
(require 'init-learning)

;; Commented out after installing Helm.
;; TODO Remove this file.
;; (require 'init-ido)
(require 'init-helm)

(require 'init-editor)
;; (require 'init-smartparens)
(require 'init-filesystem)
(require 'init-whitespace)
(require 'init-exec-path)

(require 'init-evil)
(require 'init-powerline)

(require 'init-parinfer)

(require 'init-ag)
(require 'init-projectile)
(require 'init-company)
(require 'init-ruby)
(require 'init-multiple-cursors)
(require 'init-acejump)
(require 'init-yaml)
(require 'init-web)
(require 'init-indent)
(require 'init-autocomplete)
(require 'init-clojure)
(require 'init-restclient)
(require 'init-emoji)

(require 'init-windmove)
(require 'init-markdown)

(require 'init-org)
;; (require 'init-spotify)

;; Global modes
(require 'init-global-modes)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/Dropbox/org/home.org" "~/Dropbox/org/clock-test.org" "~/Dropbox/org/tasks.org" "~/Dropbox/org/notes.org")))
 '(package-selected-packages
   (quote
    (parinfer helm-cider helm logview clj-refactor emojify restclient evil-mc yaml-mode web-mode solarized-theme smex scss-mode rvm robe rainbow-mode rainbow-delimiters powerline-evil ox-reveal multiple-cursors markdown-mode js2-mode idomenu ido-vertical-mode htmlize helm-projectile haml-mode fullframe flx-ido exec-path-from-shell evil-space evil-smartparens evil-org evil-leader evil-jumper company cider-eval-sexp-fu cider auto-complete align-cljlet ag ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit nil :height 1))))
 '(org-level-2 ((t (:inherit nil :height 1))))
 '(org-level-3 ((t (:inherit nil :height 1))))
 '(org-level-4 ((t (:inherit nil :height 1))))
 '(org-level-5 ((t (:inherit nil :height 1))))
 '(org-level-6 ((t (:inherit nil :height 1))))
 '(org-level-7 ((t (:inherit nil :height 1))))
 '(whitespace-space ((t (:foreground "#073642")))))
(put 'erase-buffer 'disabled nil)
