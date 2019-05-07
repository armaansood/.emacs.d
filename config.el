
(line-number-mode 1)
(column-number-mode 1)

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(global-set-key (kbd "<C-return>") 'ansi-term)

(global-subword-mode 1)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

(setq ring-bell-function 'ignore)

(when window-system (global-hl-line-mode t))
(add-hook 'eshell-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode
                                                nil)))
(add-hook 'term-mode-hook (lambda ()
                                    (setq-local global-hl-line-mode
                                                nil)))

(global-linum-mode)

(defalias 'yes-or-no-p 'y-or-n-p)

(add-to-list 'default-frame-alist '(height . 800))
(add-to-list 'default-frame-alist '(width . 500))

(use-package rainbow-mode
  :ensure t
  :init (rainbow-mode 1))

(use-package rainbow-delimiters
  :ensure t
  :init
  (rainbow-delimiters-mode 1))

(use-package popup-kill-ring
  :ensure t
  :bind ("M-y" . popup-kill-ring))

(show-paren-mode 1)

(tool-bar-mode -1)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode))))

(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buff 'always)
(setq ido-everywhere t)
(ido-mode 1)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex))

(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

(global-set-key (kbd "<mouse-8>") 'previous-buffer)
(global-set-key (kbd "<mouse-9>") 'next-buffer)

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(use-package switch-window
  :ensure t
  :config
  (setq switch-window-input-style 'minibuffer)
  (setq switch-window-increase 4)
  (setq switch-window-threshold 2)
  (setq switch-window-shortcut-style 'qwerty)
  (setq switch-window-qwerty-shortcuts
        '("a" "s" "d" "f" "j" "k" "l"))
  :bind
  ([remap other-window] . switch-window))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(defun kill-whole-word ()
  (interactive)
  (backward-word)
  (kill-word 1))
(global-set-key (kbd "C-c w w") 'kill-whole-word)

(defun copy-whole-line ()
  (interactive)
  (save-excursion
    (kill-new
     (buffer-substring
      (point-at-bol)
      (point-at-eol)))))
(global-set-key (kbd "C-c w l") 'copy-whole-line)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 10))))

(use-package company
    :ensure t
    :config
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 3)
    (add-hook 'after-init-hook 'global-company-mode))

  (use-package company-c-headers
    :ensure t)

(eval-after-load 'company '(add-to-list 'company-backends '(company-c-headers company-irony)))

  (with-eval-after-load 'company
    (define-key company-active-map (kbd "M-n") nil)
    (define-key company-active-map (kbd "M-p") nil)
    (define-key company-active-map (kbd "C-n") #'company-select-next)
    (define-key company-active-map (kbd "C-p") #'company-select-previous)
    (define-key company-active-map (kbd "C-g") #'company-abort))

  (use-package company-irony
    :ensure t
    :config
    (require 'company)
    (add-to-list 'company-backends 'company-irony))

  (use-package irony
    :ensure t
    :config
    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

  (with-eval-after-load 'company
    (add-hook 'c++-mode-hook 'company-mode)
    (add-hook 'c-mode-hook 'company-mode)
    (add-hook 'emacs-lisp-mode 'company-mode))

  (add-to-list 'company-backends 'company-c-headers)

(use-package flycheck
  :ensure t
  )

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(use-package irony
  :ensure t
  :config
  (progn
    ;; If irony server was never installed, install it.
    (unless (irony--find-server-executable) (call-interactively #'irony-install-server))

    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)

    ;; Use compilation database first, clang_complete as fallback.
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                    irony-cdb-clang-complete))

    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    ))

;; I use irony with company to get code completion.
(use-package company-irony
  :ensure t
  :config
  (progn
    (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

;; I use irony with flycheck to get real-time syntax checking.
(use-package flycheck-irony
  :ensure t
  :config
  (progn
    (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))

;; Eldoc shows argument list of the function you are currently writing in the echo area.
(use-package irony-eldoc
  :ensure t
  :config
  (progn
    (add-hook 'irony-mode-hook #'irony-eldoc)))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator (quote arrow))
  (spaceline-spacemacs-theme))

(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))

(use-package iedit
  :ensure t)

(use-package flymake-google-cpplint
  :ensure t)

(use-package google-c-style
  :ensure t)

(use-package flymake-cursor
  :ensure t)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "cpplint"))
  (flymake-google-cpplint-load))

(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

;; (use-package color-theme
;;   :ensure t)
;; (use-package moe-theme
;;   :ensure t)
;; (moe-light)

(use-package ggtags
  :ensure t
  :config 
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
                (ggtags-mode 1))))
  )

(add-hook 'c-mode-hook
          (lambda () (setq flycheck-clang-include-path
                           (list (expand-file-name "~/git/xk/inc/")))))

;;   (defvar myPackages
;;     '(better-defaults
;;       ein
;;       elpy
;;       flycheck
;;       material-theme
;;       py-autopep8))

;;   (mapc #'(lambda (package)
;;             (unless (package-installed-p package)
;;               (package-install package)))
;;         myPackages)
;;   (elpy-enable)
;;   (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
;;   (setq python-shell-interpreter "ipython3"
;;         python-shell-interpreter-args "-i")

;;   ;; use flycheck not flymake with elpy
;;   (when (require 'flycheck nil t)
;;     (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;     (add-hook 'elpy-mode-hook 'flycheck-mode))

;;   ;; enable autopep8 formatting on save
;;   (require 'py-autopep8)
;;   (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;;   ;; (use-package elpy
;;   ;;   :ensure t
;;   ;;   :init
;;   ;;   )
;;   ;; (elpy-enable)
;; ;;(require 'flycheck-color-mode-line)
;;  ;;  (defun company-jedi-setup ()
;;  ;;    (add-to-list 'company-backends 'company-jedi))
;;  ;;  (add-hook 'python-mode-hook 'company-jedi-setup)
;;  ;;  (setq jedi:setup-keys t)
;;  ;;  (setq jedi:complete-on-dot t)
;;  ;;  (add-hook 'python-mode-hook 'jedi:setup)
;;  ;;  (setq
;;  ;;   python-shell-interpreter "ipython"
;;  ;;   python-shell-interpreter-args "-i")
;;  ;;  (add-hook 'after-init-hook 'global-flycheck-mode)
;;  ;;  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)

;;  ;; ;; (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
;;  ;;  (require 'py-autopep8)
;; ;;  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
;; ;; define list of packages to install
;; ;; (defvar myPackages
;; ;;   '(better-defaults
;; ;; ;    material-theme
;; ;;     exec-path-from-shell
;; ;;     elpy
;; ;;     pyenv-mode))

;; ;; ;; install all packages in list
;; ;; (mapc #'(lambda (package)
;; ;;     (unless (package-installed-p package)
;; ;;       (package-install package)))
;; ;;       myPackages)

;; ;; ;; Use shell's $PATH
;; ;; (exec-path-from-shell-copy-env "PATH")
;; ;; (setq inhibit-startup-message t)   ;; hide the startup message
;; ;; ;;(load-theme 'material t)           ;; load material theme
;; ;; (global-linum-mode t)              ;; enable line numbers globally
;; ;; (setq linum-format "%4d \u2502 ")  ;; format line number spacing

;; ;; (elpy-enable)
;; ;; (pyenv-mode)
;; ;; (setq python-shell-interpreter "ipython"
;; ;;       python-shell-interpreter-args "-i --simple-prompt")
;; ;; (setq python-shell-interpreter "jupyter"
;; ;;       python-shell-interpreter-args "console --simple-prompt"
;; ;;       python-shell-prompt-detect-failure-warning nil)
;; ;; (add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter")
;; (setq python-shell-interpreter "ipython3"
;;       python-shell-interpreter-args "-i --simple-prompt")

(use-package go-mode
    :ensure t
    :config
    (add-hook 'before-save-hook #'gofmt-before-save)
    (add-hook 'go-mode-hook 'flycheck-mode)
    (add-hook 'go-mode-hook 'dumb-jump-mode)
    (setq go-packages-function 'go-packages-go-list))

  ;; (use-package company-go
  ;;   :ensure t
  ;;   :config
  ;;   (add-hook 'go-mode-hook 'company-mode)
  ;;   (add-to-list 'company-backends 'company-go))

  (use-package go-eldoc
    :diminish eldoc-mode
    :config (add-hook 'go-mode-hook 'go-eldoc-setup))


     
  ;;   (use-package go-eldoc
  ;;     :ensure t
  ;;     )
  ;;   (use-package go-autocomplete
  ;;     :ensure t
  ;;     )

  ;;   (use-package company-go
  ;;     :ensure t
  ;;     )
  (use-package exec-path-from-shell
    :ensure t
    )

  ;;   (require 'go-mode)
  ;;   ;; (add-hook 'before-save-hook 'gofmt-before-save)

  (add-hook 'go-mode-hook '(lambda ()
                             (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

  ;;   ;; (add-hook 'go-mode-hook '(lambda ()
  ;;   ;;   (local-set-key (kbd "C-c C-g") 'go-goto-imports)))

  (add-hook 'go-mode-hook '(lambda ()
                             (local-set-key (kbd "C-c C-k") 'godoc)))




  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)

  ;;   ;; (add-hook 'go-mode-hook 'company-mode)
  ;;   ;; (add-hook 'go-mode-hook (lambda ()
  ;;   ;;   (set (make-local-variable 'company-backends) '(company-go))
  ;;   ;;   (company-mode)))

  ;(add-to-list 'load-path "$GOPATH/src/github.com/dougm/goflymake")
  ;(require 'go-flymake)

  ;;   ;; (add-hook 'go-mode-hook 'go-eldoc-setup)
  ;;   ;; (add-hook 'go-mode-hook 'company-mode)

  (defun set-exec-path-from-shell-PATH ()
    (let ((path-from-shell (replace-regexp-in-string
                            "[ \t\n]*$"
                            ""
                            (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
      (setenv "PATH" path-from-shell)
      (setq eshell-path-env path-from-shell) ; for eshell users
      (setq exec-path (split-string path-from-shell path-separator))))

  (when window-system (set-exec-path-from-shell-PATH))


  (setenv "GOPATH" "/home/armaan/go")
  (add-to-list 'exec-path "/home/armaan/go/bin")
  (add-hook 'before-save-hook 'gofmt-before-save)
  ;;       (defun my-go-mode-hook ()
  ;;     (setq gofmt-command "goimports")
  ;;     ; Call Gofmt before saving                                                    
  ;;     (add-hook 'before-save-hook 'gofmt-before-save)
  ;;     ; Godef jump key binding                                                      
  ;;     (local-set-key (kbd "M-.") 'godef-jump)
  ;;     (local-set-key (kbd "M-*") 'pop-tag-mark)
  ;; (add-hook 'before-save-hook 'gofmt-before-save)
  (setq tab-width 4)
(setq-default tab-width 4)
  (setq indent-tabs-mode 1)
  ;;     )
  ;;   (add-hook 'go-mode-hook 'my-go-mode-hook)

  (defun auto-complete-for-go ()
    (auto-complete-mode 1))
  (add-hook 'go-mode-hook 'auto-complete-for-go)
  (with-eval-after-load 'go-mode
    (require 'go-autocomplete))

  ;;   (add-hook 'go-mode-hook '(lambda ()
  ;;                              (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

  ;;   (add-hook 'go-mode-hook '(lambda ()
  ;;     (local-set-key (kbd "C-c C-k") 'godoc)))
