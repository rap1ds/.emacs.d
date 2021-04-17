;;; init-ci.el --- Initialize Continuous Integration Build Status
;;;
;;; Commentary:
;;;
;;; https://github.com/sshaw/build-status
;;;
;;; Please note, this doesn't really work...
;;;
;;; The build status is appended to "global-mode-string", which should
;;; be referred in "mode-line-misc-info" which should be referred in
;;; "mode-line-format".  Couple issues: a) This doesn't seem to work
;;; with powerline.  It doesn't contain "mode-line-misc-info".  b) Even
;;; without powerline, the value that is displaed is
;;; *invalid*.  Apparently it's not ok to set the
;;; "build-status-mode-line-string" var as the value of the global
;;; mode string
;;;
;;; Code:

(require-package 'build-status)
(put 'build-status-mode-line-string 'risky-local-variable t)

(provide 'init-ci)
;;; init-ci ends here
