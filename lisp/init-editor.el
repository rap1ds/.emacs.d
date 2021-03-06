(tool-bar-mode -1)
;; (menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

; This performs very badly, disable it
; (global-hl-line-mode 1)
(set-default 'cursor-type 'bar)

;; Unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(defadvice split-window (after move-point-to-new-window activate)
      "Moves the point to the newly created window after splitting."
      (other-window 1))

(fset 'yes-or-no-p 'y-or-n-p)

(defun new-scratch-buffer (name)
  "Open a new empty buffer.
URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2016-08-11"
  (interactive "sBuffer name: ")
  (let ((-buf (generate-new-buffer name)))
    (switch-to-buffer -buf)
    (set-auto-mode)
    (setq buffer-offer-save t)))

;; http://emacsredux.com/blog/2013/04/07/display-visited-files-path-in-the-frame-title/
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))))))


(provide 'init-editor)
