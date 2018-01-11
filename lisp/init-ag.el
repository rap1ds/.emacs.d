(require-package 'ag)
(require-package 'helm-ag)

(setq ag-highlight-search t)
(setq ag-reuse-window t)
(setq ag-reuse-buffers t)

(setq helm-ag-insert-at-point 'symbol)

(provide 'init-ag)
