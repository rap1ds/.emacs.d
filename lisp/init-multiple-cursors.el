;; (require-package 'multiple-cursors)
;;
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require-package 'evil-mc)

(global-evil-mc-mode 1)

(provide 'init-multiple-cursors)
