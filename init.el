(require 'package)

(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)      

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(require 'org)

(org-babel-load-file (expand-file-name  "~/.emacs.d/config.org"))
5
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(company-c-headers-path-system
   (quote
    ("/usr/include/" "/usr/local/include/" "~/git/xk/inc/")))
 '(ede-project-directories (quote ("/home/armaan/git/xk")))
 '(elpy-rpc-python-command "python3")
 '(flycheck-clang-include-path (quote ("~/git/xk/inc/")))
 '(flymake-google-cpplint-command "cpplint")
 '(markdown-command "/usr/bin/pandoc" t)
 '(package-selected-packages
   (quote
    (company-go go-eldoc go-mode pyenv-mode exec-path-from-shell markdown-mode moe-theme color-theme google-c-style flymake-cursor flymake-cursor-mode flymake-google-cpplint company-c-headers irony-eldoc flycheck-irony treemacs iedit swiper py-autopep8 material-theme flycheck elpy ein better-defaults popup-kill-ring spaceline dashboard rainbow-mode rainbow-delimiters switch-window avy smex ido-vertical-mode org-bullets which-key use-package)))
 '(python-shell-interpreter "ipython3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
