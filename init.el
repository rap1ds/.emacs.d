;;;
;;; My emacs configurations
;;;
;;; Copied from: https://github.com/purcell/emacs.d/blob/master/init.el
;;;


;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-elpa) ;; Machinery for installing required packages
(require 'init-themes)
(require 'init-osx)
(require 'init-learning)
(require 'init-ido)
(require 'init-editor)
(require 'init-fonts)
(require 'init-filesystem)
(require 'init-whitespace)

;; Global modes
(require 'init-global-modes)
