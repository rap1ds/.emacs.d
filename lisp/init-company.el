(require-package 'company)
;; Enable the company mode autocompletion for all buffers
(require 'company)
(setq company-idle-delay 0.3)
(add-hook 'after-init-hook 'global-company-mode)

(provide 'init-company)
