(require-package 'robe)
(require-package 'inf-ruby)
(require-package 'rvm)
(require-package 'haml-mode)

(add-hook 'ruby-mode-hook 'robe-mode)
;;advice for robe to set correct ruby environment with rvm - does not work at the moment (no .rvmrc)
;;possible fix - use rvm use and select it manually
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby)
(add-hook 'robe-mode-hook 'ac-robe-setup))

(setq ruby-deep-indent-paren nil)

(provide 'init-ruby)
