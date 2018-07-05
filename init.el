
;;; Basic settings
(setq delete-by-moving-to-trash 't)
(setq inhibit-startup-screen t)

(setq-local accentcolor "#ffd05b")

(global-hl-line-mode t)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(line-number-mode)
(column-number-mode)

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

(use-package focus)

(use-package perspective
  :config
  (persp-mode))

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "3d5720f488f2ed54dd4e40e9252da2912110948366a16aef503f3e9e7dfe4915" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(dimmer-mode t nil (dimmer))
 '(global-linum-mode t)
 '(global-magit-file-mode nil)
 '(md4rd-subs-active (quote (emacs runescape lisp+Common_Lisp prolog)))
 '(nyan-mode nil)
 '(package-selected-packages
   (quote
	(yasnippet-snippets yasnippet expand-region kotlin-mode moe-theme php-mode swift-mode perspective exec-path-from-shell highlight-parentheses dockerfile-mode restart-emacs avy helm-ag yaml-mode json-mode flycheck-popup-tip elogcat md4rd logcat-mode multi-term calfw smartparens-config powerline delight doom-themes flymd multiple-cursors helm-projectile dumb-jump beacon flycheck projectile android-mode telephone-line-mode sx csharp-mode dimmer highlight-symbol restclient undo-tree magit focus auto-complete dracula-theme darcula-theme rjsx-mode nyan-mode which-key solarized-theme rainbow-mode editorconfig helm use-package)))
 '(projectile-globally-ignored-directories
   (quote
	(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "build")))
 '(restart-emacs-restore-frames t)
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

(use-package calfw)

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

(use-package helm-ag)

(use-package expand-region)

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets)

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

(use-package flycheck-popup-tip)

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

(use-package powerline
  :config
  (powerline-center-theme)
  (setq powerline-color1 "grey22")
  (setq powerline-color2 "grey40")
  (remove-hook 'focus-out-hook 'powerline-unset-selected-window)
  (set-face-attribute 'mode-line nil
                      :foreground "Black"
                      :background accentcolor
                      :box accentcolor)
  (set-face-attribute 'mode-line-inactive nil
                      :box accentcolor))

(set-face-background 'vertical-border accentcolor)
(set-face-foreground 'vertical-border (face-background 'vertical-border))

(use-package which-key
  :config
  (setq which-key-idle-delay 0.5)
  (which-key-mode))

(use-package beacon
  :config
  (beacon-mode 1))

(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines))

(use-package avy
  :config
  (global-set-key (kbd "C-:") 'avy-goto-char))

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
  (delight 'highlight-parentheses-mode nil 'highlight-parentheses))

(use-package nyan-mode
  :config
  (setq nyan-wavy-trail 't))

(use-package restart-emacs)

(global-unset-key "\C-z")
(global-set-key (kbd "C-z") 'universal-argument)
(global-linum-mode 1)


;; Completed initialization
(message "Initialized successfully.")
