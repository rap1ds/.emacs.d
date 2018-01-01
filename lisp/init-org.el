;;; evil-org.el --- evil keybindings for org-mode

;; Copyright (C) 2012-2014 by Edward Tjörnhammar
;; Author: Edward Tjörnhammar
;; URL: https://github.com/edwtjo/evil-org-mode.git
;; Git-Repository; git://github.com/edwtjo/evil-org-mode.git
;; Created: 2012-06-14
;; Version: 0.1.1
;; Package-Requires: ((evil "0") (org "0"))
;; Keywords: evil vim-emulation org-mode key-bindings presets

;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Known Bugs:
;; See, https://github.com/edwtjo/evil-org-mode/issues
;;
;;; Code:
(require 'evil)
(require 'org)

(define-minor-mode evil-org-mode
  "Buffer local minor mode for evil-org"
  :init-value nil
  :lighter " EvilOrg"
  :keymap (make-sparse-keymap) ; defines evil-org-mode-map
  :group 'evil-org)

(add-hook 'org-mode-hook 'evil-org-mode) ;; only load with org-mode

(defun clever-insert-item ()
  "Clever insertion of org item."
  (if (not (org-in-item-p))
      (insert "\n")
    (org-insert-item))
  )

(defun evil-org-eol-call (fun)
  "Go to end of line and call provided function.
FUN function callback"
  (end-of-line)
  (funcall fun)
  (evil-append nil)
  )

;; recompute clocks in visual selection
(evil-define-operator evil-org-recompute-clocks (beg end type register yank-handler)
  :keep-visual t
  :move-point nil
  (interactive "<r>")
  (progn
        (message "start!" )
        (save-excursion
        (while (< (point) end)
            (org-evaluate-time-range)
            (next-line)
            (message "at position %S" (point))
        ))))

;; open org-mode links in visual selection
(defun evil-org-generic-open-links (beg end type register yank-handler incog)
  (progn
    (save-excursion
      (goto-char beg)
      (catch 'break
        (while t
          (org-next-link)
          ;;; break from outer loop when there are no more
          ;;; org links
          (when (or
                 (not (< (point) end))
                 (not (null org-link-search-failed)))
            (throw 'break 0))

          (if (not (null incog))
              (let* ((new-arg
                      ;;; if incog is true, decide which incognito settings to
                      ;;; use dependening on the browser
                      (cond ((not (null (string-match "^.*\\(iceweasel\\|firefox\\).*$" browse-url-generic-program)))  "--private-window")
                            ((not (null (string-match "^.*\\(chrome\\|chromium\\).*$"  browse-url-generic-program)))   "--incognito"     )
                            (t "")
                            ))
                     (old-b (list browse-url-generic-args " " ))
                     (browse-url-generic-args (add-to-ordered-list 'old-b new-arg 0)))
                (progn
                  (org-open-at-point)))
            (let ((browse-url-generic-args '("")))
              (org-open-at-point)))
          )))))


;;; open links in visual selection
(evil-define-operator evil-org-open-links (beg end type register yank-handler)
  :keep-visual t
  :move-point nil
  (interactive "<r>")
  (evil-org-generic-open-links beg end type register yank-handler nil)
)

;;; open links in visual selection in incognito mode
(evil-define-operator evil-org-open-links-incognito (beg end type register yank-handler)
  :keep-visual t
  :move-point nil
  (interactive "<r>")
  (evil-org-generic-open-links beg end type register yank-handler t)
)

;; normal state shortcuts
(evil-define-key 'normal evil-org-mode-map
  "gh" 'outline-up-heading
  "gp" 'outline-previous-heading
  "gj" (if (fboundp 'org-forward-same-level) ;to be backward compatible with older org version
	   'org-forward-same-level
	  'org-forward-heading-same-level)
  "gk" (if (fboundp 'org-backward-same-level)
	   'org-backward-same-level
	  'org-backward-heading-same-level)
  "gl" 'outline-next-visible-heading
  "t" 'org-todo
  "T" '(lambda () (interactive) (evil-org-eol-call (lambda() (org-insert-todo-heading nil))))
  "H" 'org-beginning-of-line
  "L" 'org-end-of-line
  "o" '(lambda () (interactive) (evil-org-eol-call 'clever-insert-item))
  "O" '(lambda () (interactive) (evil-org-eol-call 'org-insert-heading))
  "$" 'org-end-of-line
  "^" 'org-beginning-of-line
  "<" 'org-metaleft
  ">" 'org-metaright
  "-" 'org-cycle-list-bullet
  (kbd "TAB") 'org-cycle)

;; leader maps
(evil-leader/set-key-for-mode 'org-mode
  "t"  'org-show-todo-tree
  "a"  'org-agenda
  ;; "c"  'org-archive-subtree
  ;; leader-c clashes with capture mode leader
  "l"  'evil-org-open-links
  "o"  'evil-org-recompute-clocks
)

;; normal & insert state shortcuts.
(mapc (lambda (state)
        (evil-define-key state evil-org-mode-map
          (kbd "M-l") 'org-metaright
          (kbd "M-h") 'org-metaleft
          (kbd "M-k") 'org-metaup
          (kbd "M-j") 'org-metadown
          (kbd "M-L") 'org-shiftmetaright
          (kbd "M-H") 'org-shiftmetaleft
          (kbd "M-K") 'org-shiftmetaup
          (kbd "M-J") 'org-shiftmetadown
          (kbd "M-o") '(lambda () (interactive)
                         (evil-org-eol-call
                          '(lambda()
                             (org-insert-heading)
                             (org-metaright))))
          (kbd "M-t") '(lambda () (interactive)
                         (evil-org-eol-call
                          '(lambda()
                             (org-insert-todo-heading nil)
                             (org-metaright))))
          ))
      '(normal insert))

(provide 'evil-org)
;;; evil-org.el ends here

(require-package 'ox-reveal)
(require-package 'htmlize)

(setq org-reveal-root "file:///Users/mikko/.emacs.d/reveal.js-3.2.0")

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

(setq org-todo-keywords
      '((sequence "TODO" "WIP" "|" "DONE")))

;; Setting Colours (faces) for todo states to give clearer view of work
(setq org-todo-keyword-faces
  '(("WIP" . "yellow")
    ("DONE" . "green")))

(setq org-agenda-custom-commands
      '(
        ("w" "Work Agenda"
         (
          (agenda ""
                  (
                   (org-agenda-files '("~/Dropbox/org/tasks.org"))
                    (org-agenda-prefix-format " %?-12t% s")
                    ))
          (todo "DONE" (
                        (org-agenda-files '("~/Dropbox/org/tasks.org"))
                        (org-agenda-sorting-strategy '(timestamp-down))
                        (org-agenda-max-todos 25)
                        ))
          ))
        ("h" "Home Agenda"
         (
          (agenda ""
                  (
                   (org-agenda-files '("~/Dropbox/org/home.org"))
                    (org-agenda-prefix-format " %?-12t% s")
                    ))
          (todo "DONE" (
                        (org-agenda-files '("~/Dropbox/org/home.org"))
                        (org-agenda-sorting-strategy '(timestamp-down))
                        (org-agenda-max-todos 25)
                        ))
          ))
        ))

;; Evil bindings:
;;
;; https://github.com/edwtjo/evil-org-mode/blob/master/evil-org.el
;; https://github.com/tarleb/evil-rebellion/blob/master/evil-org-rebellion.el

(setq org-capture-templates
      '(
        ("t" "(t)ask" entry (file+headline (lambda () (concat org-directory "/tasks.org")) "Tasks")
         "* TODO %?\n  SCHEDULED: %t %i")
        ("T" "(T)ask with link" entry (file+headline (lambda () (concat org-directory "/tasks.org")) "Tasks")
         "* TODO %?\n  SCHEDULED: %(org-insert-time-stamp (current-time)) %i\n  %a")
        ("h" "(h)ome task" entry (file+headline (lambda () (concat org-directory "/home.org")) "Home tasks")
         "* TODO %?\n  SCHEDULED: %t %i")
        ("n" "(n)ote" entry (file+headline (lambda () (concat org-directory "/notes.org")) "Notes")
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
      "gm" 'org-agenda-month-view
      "gw" 'org-agenda-week-view
      "gd" 'org-agenda-day-view
      )))

;; Global evil leader keys
(evil-leader/set-key
  "a" 'org-agenda
  "c" 'org-capture)

(provide 'init-org)
