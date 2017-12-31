(require-package 'projectile)

(projectile-global-mode)

;; Install Helm UI for Projectile
(require-package 'helm-projectile)

;; Use helm as completion system
(setq projectile-completion-system 'helm)

;; Enable helm keybindings
(helm-projectile-on)

(provide 'init-projectile)
