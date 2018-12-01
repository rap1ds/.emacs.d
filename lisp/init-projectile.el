(require-package 'projectile)

(projectile-global-mode)

;; Install Helm UI for Projectile
(require-package 'helm-projectile)

;; Use helm as completion system
(setq projectile-completion-system 'helm)

;; Enable helm keybindings
(helm-projectile-on)

;; According to the projectile readme (https://github.com/bbatsov/projectile/blob/a4b447d980b10cbb8d175d64e4305b4504c03d83/README.md)
;;, I should add these:
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(provide 'init-projectile)
