(require-package 'evil-org)
(require 'evil-org)

(custom-set-faces
 '(org-level-1 ((t (:inherit nil :height 1))))
 '(org-level-2 ((t (:inherit nil :height 1))))
 '(org-level-3 ((t (:inherit nil :height 1))))
 '(org-level-4 ((t (:inherit nil :height 1))))
 '(org-level-5 ((t (:inherit nil :height 1))))
 '(org-level-6 ((t (:inherit nil :height 1))))
 '(org-level-7 ((t (:inherit nil :height 1))))
 )

(setq org-log-done t)
(setq org-startup-truncated nil)
(setq org-directory "~/Dropbox/org")

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-agenda-span 'day)
(setq org-clock-idle-time 20)

;; Evil bindings:
;;
;; https://github.com/edwtjo/evil-org-mode/blob/master/evil-org.el
;; https://github.com/tarleb/evil-rebellion/blob/master/evil-org-rebellion.el

(setq org-capture-templates
      '(
        ("t" "(t)ask" entry (file+headline (concat org-directory "/tasks.org") "Tasks")
         "* TODO %?\n  SCHEDULED: %t %i")
        ("T" "(T)ask with link" entry (file+headline (concat org-directory "/tasks.org") "Tasks")
         "* TODO %?\n  SCHEDULED: %(org-insert-time-stamp (current-time)) %i\n  %a")
        ("s" "Day (s)tarted" entry (file+headline (concat org-directory "/worktime-tracking.org") "Worktime tracking")
         "* Start %(org-time-stamp nil)")
        ("e" "Day (e)nded at" entry (file+headline (concat org-directory "/worktime-tracking.org") "Worktime tracking")
         "* End %(org-time-stamp nil), idle %? min")
        ("c" "Clock in" entry (file+headline (concat org-directory "/clock-test.org") "Working...")
         "* %(org-insert-time-stamp (current-time))" :prepend t :clock-in t :clock-keep t)
        ("n" "(n)ote" entry (file+headline (concat org-directory "/notes.org") "Notes")
         "* %?\n")
        ))

;; Start org-agenda in Normal evil node
(eval-after-load 'org-agenda
 '(progn
    (evil-set-initial-state 'org-agenda-mode 'normal)
    (evil-define-key 'normal org-agenda-mode-map
      "t" 'org-agenda-todo
      "r" 'org-agenda-redo
      "$" 'org-agenda-archive
      "q" 'org-agenda-quit
      "O" 'org-agenda-clock-out
      "R" 'org-agenda-clockreport-mode
      )))

;; Global evil leader keys
(evil-leader/set-key
  "a" 'org-agenda
  "c" 'org-capture)

(provide 'init-org)
