(require-package 'solarized-theme)

;; (load-theme 'solarized-dark t)

(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (select-frame frame)
            (set-frame-font "source code pro")
            (load-theme 'solarized-dark t)))
  (load-theme 'solarized-dark t)
  (set-frame-font "source code pro"))

(provide 'init-themes)
