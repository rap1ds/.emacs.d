(require-package 'auto-complete)
(require 'auto-complete-config)

(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'ruby-mode)

(provide 'init-autocomplete)
