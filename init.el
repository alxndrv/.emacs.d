
;;; Basic settings
(setq delete-by-moving-to-trash 't)
(setq inhibit-startup-screen t)

(global-hl-line-mode t)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(line-number-mode)
(column-number-mode)

(unless (string-equal system-type "darwin")
  (set-face-attribute 'default nil :height 115 :family "Consolas")
  )

(setq ns-use-srgb-colorspace nil)

;; Default tab width 2
(setq-default tab-width 2)

;; Scrolling settings (primarily for Mac)
(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)

;; Parentheses highlighting and pairing
(show-paren-mode)
(electric-pair-mode)

(setq major-mode 'text-mode)

;;Custom backup directory
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

(ido-mode t)

(winner-mode t)

(windmove-default-keybindings)


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

(use-package doom-themes
	:config
	(load-theme 'doom-one t))

(use-package magit
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package focus)

(use-package undo-tree)

(use-package restclient)

(use-package highlight-symbol)

(use-package dimmer
  :config
  (dimmer-mode))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 (quote
		("3d5720f488f2ed54dd4e40e9252da2912110948366a16aef503f3e9e7dfe4915" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(dimmer-mode t nil (dimmer))
 '(global-linum-mode t)
 '(global-magit-file-mode nil)
 '(nyan-mode nil)
 '(package-selected-packages
	 (quote
		(powerline delight doom-themes flymd multiple-cursors helm-projectile dumb-jump beacon flycheck projectile android-mode telephone-line-mode sx csharp-mode dimmer highlight-symbol restclient undo-tree magit focus auto-complete dracula-theme darcula-theme rjsx-mode nyan-mode which-key solarized-theme rainbow-mode editorconfig helm use-package)))
 '(projectile-globally-ignored-directories
	 (quote
		(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "build")))
 '(rich-minority-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun indent-buffer ()
  "Indent an entire buffer using the default intenting scheme."
  (interactive)
  (save-excursion
    (delete-trailing-whitespace)
    (indent-region (point-min) (point-max) nil)
    (untabify (point-min) (point-max))))


(use-package android-mode)

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

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package auto-complete
  :config
  (ac-config-default)
	(setq ac-auto-show-menu 0.4))

(use-package flycheck
	:ensure t
	:init (global-flycheck-mode))

(use-package rainbow-mode
  :config
  (rainbow-mode))

(use-package org)

(use-package rjsx-mode)
(add-to-list 'auto-mode-alist '("\\.jsx?$" . rjsx-mode))

(use-package csharp-mode)

(use-package dumb-jump
	:config
	(dumb-jump-mode))

(use-package powerline
	:config
	(powerline-center-theme)
	(setq powerline-color1 "grey22")
	(setq powerline-color2 "grey40")
	(set-face-attribute 'mode-line nil
											:foreground "Black"
											:background "DarkOrange"
											:box nil))

(use-package which-key
  :config
  (setq which-key-idle-delay 0.5)
  (which-key-mode))

(use-package beacon
	:config
	(beacon-mode 1))

(use-package delight
	:config
	(delight 'flycheck-mode " \u2714" 'flycheck)
	(delight 'auto-complete-mode " \u2630" 'auto-complete)
	(delight 'helm-mode " \u2388" 'helm)
	(delight 'editorconfig-mode nil 'editorconfig)
	(delight 'which-key-mode nil 'which-key)
	(delight 'beacon-mode nil 'beacon)
	(delight 'rainbow-mode nil 'rainbow-mode)
	(delight 'auto-revert-mode nil 'autorevert))

(use-package nyan-mode
  :config
  (setq nyan-wavy-trail 't))

(global-unset-key "\C-z")
(global-set-key (kbd "C-z") 'universal-argument)
(global-linum-mode 1)


;; Completed initialization
(message "Initialized successfully.")
