;; This perform very bad
(global-whitespace-mode t)

;; Show only whitespaces listed on the list and disable e.g. newline
(setq whitespace-style (quote
   (face spaces space-mark tabs tab-mark trailing)))

;; Less contrast for whitespaces
(custom-set-faces
 '(whitespace-space ((t (:foreground "#073642")))))

;; Clean whitespaces on every save
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Require final newline
(setq mode-require-final-newline t)

(provide 'init-whitespace)
