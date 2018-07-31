
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "9d9fda57c476672acd8c6efeb9dc801abea906634575ad2c7688d055878e69d6" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "3d5720f488f2ed54dd4e40e9252da2912110948366a16aef503f3e9e7dfe4915" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(git-messenger:show-detail t)
 '(git-messenger:use-magit-popup t)
 '(global-linum-mode t)
 '(global-magit-file-mode nil)
 '(md4rd-subs-active (quote (emacs runescape lisp+Common_Lisp prolog)))
 '(package-selected-packages
   (quote
	(ace-window all-the-icons neotree neo-tree smart-mode-line-powerline-theme smart-mode-line git-messenger anzu elscreen dashboard yasnippet-snippets yasnippet expand-region kotlin-mode php-mode swift-mode exec-path-from-shell highlight-parentheses dockerfile-mode restart-emacs avy helm-ag yaml-mode json-mode flycheck-popup-tip elogcat md4rd logcat-mode multi-term smartparens-config delight doom-themes flymd multiple-cursors helm-projectile dumb-jump beacon flycheck projectile android-mode sx csharp-mode dimmer highlight-symbol restclient undo-tree magit focus auto-complete dracula-theme darcula-theme rjsx-mode which-key solarized-theme rainbow-mode editorconfig helm use-package)))
 '(projectile-globally-ignored-directories
   (quote
	(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "build")))
 '(restart-emacs-restore-frames t)
 '(size-indication-mode nil))

;;; Basic settings
(setq delete-by-moving-to-trash 't)
(setq inhibit-startup-screen t)

;(setq-local accentcolor "#ffd05b")

(global-hl-line-mode t)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(line-number-mode)
(column-number-mode)

;; Increase GC trigger threshhold
(setq gc-cons-threshold 50000000)

(unless (string-equal system-type "darwin")
  (set-face-attribute 'default nil :height 115 :family "Consolas")
  )

(setq ns-use-srgb-colorspace nil)

;; Default tab width 4
(setq-default tab-width 4)

;; Scrolling settings (primarily for Mac)
(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)

;; Parentheses highlighting and pairing
(setq show-paren-delay 0)
(show-paren-mode)
(electric-pair-mode)

(setq major-mode 'text-mode)

;;Custom backup directory
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq create-lockfiles nil)

(ido-mode t)

(winner-mode t)
(windmove-default-keybindings)

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)


;; Bootstrap use-package
(setq package-enable-at-startup nil)
(require 'package)
(add-to-list 'package-archives  '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t
      use-package-verbose t)

;; Packages

;; (use-package dracula-theme
;;   :demand
;;   :config
;;   (load-theme 'dracula t))

(use-package solarized-theme
  :demand
  :config
  (setq x-underline-at-descent-line t)
  (load-theme 'solarized-dark t)
  ;; (custom-set-faces
  ;;  '(mode-line ((t
  ;; 				 (:underline nil :overline nil :box
  ;; 							 (:line-width 1 :color "#fdf6e3")
  ;; 							 :foreground "#fdf6e3" :background "#657b83")))))
  )

;; (use-package moe-theme
;;   :demand
;;   :config
;;   (moe-dark))

(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
	(exec-path-from-shell-initialize)))

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package git-messenger)

(use-package focus)

(use-package all-the-icons)

(use-package elscreen
  :config
  (elscreen-start))

(use-package undo-tree)

(use-package restclient)

(use-package highlight-symbol)

(use-package highlight-parentheses
  :config
  (global-highlight-parentheses-mode))

(use-package dimmer
  :config
  (dimmer-mode))

(use-package md4rd)

(use-package sx
  :config
  (bind-keys :prefix "C-c s"
             :prefix-map my-sx-map
             :prefix-docstring "Global keymap for SX."
             ("q" . sx-tab-all-questions)
             ("i" . sx-inbox)
             ("o" . sx-open-link)
             ("u" . sx-tab-unanswered-my-tags)
             ("a" . sx-ask)
             ("s" . sx-search)))

;; Cursor settings
(setq-default cursor-type 'bar
              visible-bell 't
              ring-bell-function 'ignore)

(set-cursor-color "#00ff00")

(defun indent-buffer ()
  "Indent an entire buffer using the default intenting scheme."
  (interactive)
  (save-excursion
    (delete-trailing-whitespace)
    (indent-region (point-min) (point-max) nil)
    (untabify (point-min) (point-max))))

(use-package multi-term)

(use-package android-mode)

(use-package elogcat)

;; Helm configuration
(use-package helm
  :config
  (require 'helm-config)
  (setq helm-mode-fuzzy-match t
        helm-completion-in-region-fuzzy-match t)
  (setq helm-ff-skip-boring-files t
        helm-ff-file-name-history-use-recentf t)
  (setq helm-boring-file-regexp-list
        '("\\.git$" "^.$" "^..$"))
  ;; swap C-z and TAB in helm buffers
  ;; stolen from spacemacs
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z") 'helm-select-action)
  (helm-mode)
  :bind ("M-x" . helm-M-x)
  :bind ("C-x C-f" . helm-find-files)
  :bind ("C-x b" . helm-buffers-list)
  :bind ("C-c G" . helm-google-suggest)
  :bind ("C-c g" . helm-grep-do-git-grep)
  :bind (:map helm-map
              ("C-j" . helm-next-line)
              ("C-k" . helm-previous-line)
              ("C-h" . helm-next-source)
              ("C-j" . helm-next-line)
              ([escape] . helm-keyboard-quit)))

(use-package projectile
  :config
  (projectile-mode))

(use-package helm-projectile
  :config
  (helm-projectile-on))

(use-package neotree
  :config
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (global-set-key [f8] 'neotree-toggle))

(use-package helm-ag)

(use-package anzu
  :config
  (global-anzu-mode +1))

(use-package expand-region)

(use-package yasnippet-snippets)

(use-package yasnippet
  :after yasnippet-snippets
  :config
  (yas-global-mode 1))

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (setq ac-auto-show-menu 0.4)
  (add-to-list 'ac-modes 'rjsx-mode)
  (add-to-list 'ac-modes 'kotlin-mode)
  (global-auto-complete-mode t))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(use-package flycheck-popup-tip
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode))

(use-package rainbow-mode
  :config
  (rainbow-mode))

(use-package org)

(use-package rjsx-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . rjsx-mode)))

(use-package json-mode)

(use-package csharp-mode)

(use-package kotlin-mode)

(use-package swift-mode)

(use-package php-mode)

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" .  yaml-mode)))

(use-package dockerfile-mode
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package dumb-jump
  :config
  (dumb-jump-mode))

(use-package smart-mode-line
  :init
  (setq sml/shorten-directory 't
		sml/shorten-modes 't)
  :config
  (sml/setup)
  (sml/apply-theme 'respectful)
  )

(use-package which-key
  :config
  (setq which-key-idle-delay 0.5)
  (which-key-mode))

(use-package beacon
  :config
  (beacon-mode 1))

(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this))

(use-package avy
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char))

(use-package ace-window
  :config
  (global-set-key (kbd "M-o") 'ace-window))

(use-package delight
  :config
  (delight 'flycheck-mode " \u2714" 'flycheck)
  (delight 'auto-complete-mode " \u2630" 'auto-complete)
  (delight 'helm-mode " \u2388" 'helm)
  (delight 'editorconfig-mode nil 'editorconfig)
  (delight 'which-key-mode nil 'which-key)
  (delight 'beacon-mode nil 'beacon)
  (delight 'rainbow-mode nil 'rainbow-mode)
  (delight 'auto-revert-mode nil 'autorevert)
  (delight 'highlight-parentheses-mode nil 'highlight-parentheses)
  (delight 'eldoc-mode nil 'eldoc)
  (delight 'anzu-mode nil 'anzu))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Welcome back!")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-items '((recents  . 5)
                          (bookmarks . 5)
                          (projects . 5)
                          (agenda . 5)
                          (registers . 5)))
)

;(global-unset-key "\C-z")
;(global-set-key (kbd "C-z") 'universal-argument)
(global-linum-mode 1)


;; Completed initialization
(message "Initialized successfully.")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
