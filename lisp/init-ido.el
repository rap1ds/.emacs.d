(require-package 'flx-ido)
(require-package 'smex)
(require-package 'ido-vertical-mode)

;; Enable ido for better file navigation & buffer switching
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
(ido-everywhere 1)
(flx-ido-mode 1) ;; Improved flex matching algorithm
;; Disable ido faces to see flx highlights
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t
      ido-use-faces nil)

;; smex for better m-x (fuzzy completion etc.)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c M-x") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(provide 'init-ido)
