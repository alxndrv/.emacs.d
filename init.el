(setq delete-by-movind-trash 't)

(global-hl-line-mode t)

(tool-bar-mode -1)
(scroll-bar-mode -1)

(line-number-mode)
(column-number-mode)

(setq tab-width 2)
(setq mouse-wheel-scroll-amount '(1))

(show-paren-mode)

(electric-pair-mode)

(setq defalt-major-mode 'text-mode)

(ido-mode t)

(winner-mode t)

(windmove-default-keybindings)

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

(use-package solarized-theme
  :demand
  :config
  (load-theme 'solarized-dark t)
  (setq cursor-type 'bar
	visible-bell 't)
  (set-cursor-color "#00ff00"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-linum-mode t)
 '(package-selected-packages
   (quote
    (nyan-mode which-key solarized-theme rainbow-mode editorconfig helm use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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

(use-package editorconfig
  :config
  (editorconfig-mode 1))
(use-package rainbow-mode)

(use-package which-key
  :config
  (setq which-key-idle-delay 0.5)
  (which-key-mode))

(use-package nyan-mode
  :config
  (setq nyan-wavy-trail 't))

(global-unset-key "\C-z")
(global-set-key (kbd "C-z") 'universal-argument)
(global-linum-mode 1)
