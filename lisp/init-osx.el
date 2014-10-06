;; for mac it's easier to preserve alt for things like [, {, \, |, etc.
;; and use cmd as meta instead.
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq ns-right-command-modifier 'super)
  (setq ns-option-modifier nil))

(provide 'init-osx)
