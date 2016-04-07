;; automatically refresh all buffers when files change outside emacs
(global-auto-revert-mode t)

;;----------------------------------------------------------------------------
;; Rename the current file
;;----------------------------------------------------------------------------
;; Credits: https://github.com/purcell/emacs.d/blob/master/lisp/init-utils.el
;;
(defun rename-this-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (unless filename
      (error "Buffer '%s' is not visiting a file!" name))
    (if (get-buffer new-name)
        (message "A buffer named '%s' already exists!" new-name)
      (progn
        (when (file-exists-p filename)
         (rename-file filename new-name 1))
        (rename-buffer new-name)
        (set-visited-file-name new-name)))))

;;----------------------------------------------------------------------------
;; Delete the current file
;;----------------------------------------------------------------------------
;; Credits: https://github.com/purcell/emacs.d/blob/master/lisp/init-utils.el
;;
(defun delete-this-file-and-buffer ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (or (buffer-file-name) (error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
                             (file-name-nondirectory buffer-file-name)))
    (delete-file (buffer-file-name))
    (kill-this-buffer)))

(provide 'init-filesystem)
