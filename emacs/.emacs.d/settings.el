(setq user-full-name    "Max Nerius"
      user-mail-address "mnerius@gmx.de")

(require 'package)
;; Any add to list for package-archives (to add marmalade or melpa) goes here
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(base16-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-compile
             :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

(use-package which-key
  :config
  (which-key-mode 1))

(use-package evil
  :config
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package magit)

(menu-bar-mode 0)

(tool-bar-mode 0)

(setq-default display-line-numbers 'relative)

(toggle-scroll-bar 0)

;; set default font
;;(set-frame-font "Hack 10")
;;(set-frame-font "Fira Code 10")
;;(set-frame-font "DejaVu Sans Mono 10")
;(set-frame-font "Office Code Pro 10") ;that one's pretty good!
;;(set-frame-font "Fantasque Sans Mono 11")
;;(set-frame-font "Liberation Mono 10")
;;(set-frame-font "Source Code Pro 11")
;;(set-frame-font "Input Mono Narrow 10")
;;(set-frame-font "Hack Nerd Font 10")
;;(set-frame-font "Iosevka 11")
;;(set-frame-font "Ubuntu Mono 12")
;(set-frame-font "Noto Sans Mono 10")

;;(load-theme 'base16-espresso t)
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))
;(load-theme 'solarized-light t)

(setq split-width-threshold nil)
(setq split-height-threshold 0)

(setq-default inhibit-startup-screen t)
;(setq inhibit-splash-screen t)
;(setq inhibit-startup-message t)
;(setq initial-scratch-message "")

;(setq initial-major-mode 'fundamental-mode)

(setq initial-major-mode 'org-mode)

(setq initial-scratch-message "\
#+title: Titel
#+author: Max Nerius
#+date: \\today")

(setq org-log-done 'time)

(custom-set-variables
 '(org-directory "~/Dropbox/orgfiles/")
 '(org-agenda-files (list org-directory)))

; should use org-directory instead of an absolute path
(setq org-default-notes-file (concat org-directory "notes.org"))

(setq org-capture-templates
      '(("t" "Todo" entry (file "agenda.org")
         "* TODO %?\n %i\n")
        ("c" "Media recommendation" entry (file "recom.org")
         "* %?\n %i\n")
        ("z" "Quote" entry (file "quotes.org")
         "* %?\n %i\n")
        ("i" "Idee" entry (file "ideen.org")
         "* %?\n %i\n")))

(add-hook 'auto-save-hook 'org-save-all-org-buffers)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)

(global-set-key "\C-ca" 'org-agenda)

(setq org-todo-keywords
'((sequence "TODO(t)" "START(s)" "WAIT(w)" "|" "DONE(d)" "CANCELLED(c)" "DELEGATED(a)")))

(setq org-ellipsis "⤵")

(setq org-src-fontify-natively t)

(setq org-src-tab-acts-natively t)

(setq org-agenda-include-diary t)

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-evil)

(global-set-key (kbd "C-c c") 'compile)
(global-set-key (kbd "C-c r") 'recompile)

(global-set-key (kbd "C-c m") 'magit-status)

(use-package zig-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.zig\\'" . zig-mode)))

(use-package rust-mode
  :config
  (add-hook 'rust-mode-hook (lambda () (setq indent-tabs-mode nil)))
  (setq rust-format-on-save t))

;(use-package tuareg-mode)

(use-package nim-mode)

(setq-default c-basic-offset 4)

(use-package kotlin-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(electric-pair-mode 1)

(setq backup-directory-alist
        `(("." . ,(concat user-emacs-directory "backups"))))

(use-package move-text
  :config
  (global-set-key (kbd "M-p") 'move-text-up)
  (global-set-key (kbd "M-n") 'move-text-down))

(global-set-key (kbd "C-,") 'other-window)
(org-defkey org-mode-map (kbd "C-,") 'other-window)
