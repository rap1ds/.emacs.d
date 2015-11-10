(require-package 'robe)
(require-package 'inf-ruby)
(require-package 'rvm)
(require-package 'haml-mode)

(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'my-evil/extend-word-definition)
;;advice for robe to set correct ruby environment with rvm - does not work at the moment (no .rvmrc)
;;possible fix - use rvm use and select it manually
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))

(add-hook 'robe-mode-hook 'ac-robe-setup)

(push 'company-robe company-backends)

;; Rebind M-. back to 'robe-jump instead of evil mode repeat
(evil-define-key 'normal ruby-mode-map (kbd "M-.") 'robe-jump)

;; https://github.com/purcell/emacs.d/blob/master/lisp/init-ruby-mode.el
(with-eval-after-load 'ruby-mode
  (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent))

(provide 'init-ruby)
