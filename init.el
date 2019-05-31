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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#212121" "#B71C1C" "#558b2f" "#FFA000" "#2196f3" "#4527A0" "#00796b" "#FAFAFA"))
 '(column-number-mode t)
 '(company-c-headers-path-system
   (quote
    ("/usr/include/" "/usr/local/include/" "~/git/xk/inc/")))
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("13d20048c12826c7ea636fbe513d6f24c0d43709a761052adbca052708798ce3" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "732b807b0543855541743429c9979ebfb363e27ec91e82f463c91e68c772f6e3" default)))
 '(ede-project-directories (quote ("/home/armaan/git/xk")))
 '(elpy-rpc-python-command "python3")
 '(fci-rule-color "#ECEFF1")
 '(flycheck-clang-include-path (quote ("~/git/xk/inc/")))
 '(flymake-google-cpplint-command "cpplint")
 '(hl-sexp-background-color "#efebe9")
 '(markdown-command "/usr/bin/pandoc" t)
 '(package-selected-packages
   (quote
    (company-go go-eldoc go-mode pyenv-mode exec-path-from-shell markdown-mode moe-theme color-theme google-c-style flymake-cursor flymake-cursor-mode flymake-google-cpplint company-c-headers irony-eldoc flycheck-irony treemacs iedit swiper py-autopep8 material-theme flycheck elpy ein better-defaults popup-kill-ring spaceline dashboard rainbow-mode rainbow-delimiters switch-window avy smex ido-vertical-mode org-bullets which-key use-package)))
 '(python-shell-interpreter "ipython3")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#B71C1C")
     (40 . "#FF5722")
     (60 . "#FFA000")
     (80 . "#558b2f")
     (100 . "#00796b")
     (120 . "#2196f3")
     (140 . "#4527A0")
     (160 . "#B71C1C")
     (180 . "#FF5722")
     (200 . "#FFA000")
     (220 . "#558b2f")
     (240 . "#00796b")
     (260 . "#2196f3")
     (280 . "#4527A0")
     (300 . "#B71C1C")
     (320 . "#FF5722")
     (340 . "#FFA000")
     (360 . "#558b2f"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
