;;; init-flycheck.el --- Init flycheck
;;; Commentary:
;;; Code:

(require-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-emacs-lisp-load-path 'inherit)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
