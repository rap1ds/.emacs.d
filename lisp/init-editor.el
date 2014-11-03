(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

; This performs very badly, disable it
; (global-hl-line-mode 1)
(set-default 'cursor-type 'bar)

;; Unique buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(defadvice split-window (after move-point-to-new-window activate)
      "Moves the point to the newly created window after splitting."
      (other-window 1))

(fset 'yes-or-no-p 'y-or-n-p)

(provide 'init-editor)
