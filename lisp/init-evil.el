(require-package 'evil)
(require-package 'evil-leader)
(require-package 'evil-surround)

(evil-mode 1)
(global-evil-surround-mode 1)
(setq evil-shift-width 2)

(global-evil-leader-mode)

(evil-leader/set-key
  "f" 'helm-projectile-find-file
  "b" 'helm-mini
  "s" 'helm-projectile-ag
  "n" 'new-scratch-buffer
  )

(define-key evil-normal-state-map (kbd "§") 'evil-execute-in-emacs-state)

;; Make evil behave like Vim by including _ and - to definition of a word
;; See FAQ at the bottom of: https://bitbucket.org/lyro/evil/wiki/Home
(defun my-evil/extend-word-definition ()
  "Make _ and - part of the word definition in current buffer. Enable mode wide by attaching to mode hook."
  (interactive)
  (modify-syntax-entry ?_ "w")
  (modify-syntax-entry ?- "w"))

(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("blue" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(provide 'init-evil)
