(require-package 'ag)

(require-package 'projectile)
(projectile-global-mode)
(setq ag-highlight-search t)
(setq ag-reuse-window t)
(setq ag-reuse-buffers t)

(provide 'init-projectile)
