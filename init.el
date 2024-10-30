(setq inhibit-startup-message t)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(set-fringe-mode 10)

(menu-bar-mode 0)
(blink-cursor-mode 0)
(setq default-tab-width 4)
(tab-bar-mode 1)



; (setq visible-bell t)
(setq ring-bell-function 'ignore)

(setq auto-save-default nil)
(setq make-backup-files nil) ; stop creating ~ files

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")

(add-hook 'server-after-make-frame-hook
	  (lambda ()
	    (if (file-exists-p "/mnt/T7/due.org")
		(find-file "/mnt/T7/due.org"))))



;; Package Manager
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Line Numbers
(column-number-mode)
;; (global-display-line-numbers-mode t)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(dolist(mode '(org-mode-hook
	       term-mode-hook
	       eshell-mode-hook
	       shell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(setq-default display-line-numbers-type 'relative)

;; ========== My THEMES ======================================
;; (load-theme 'zenburn t)
;; (load-theme 'dracula t)
(load-theme 'RDKDeeperBlueNewFontNEW t)
(global-hl-line-mode)

(use-package projectile)
(projectile-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; ==== Language Server Stuff ====

;; LSP Mode Package
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (c-mode . lsp)
	 (c++-mode . lsp)
	 (java-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(setq-default lsp-enable-on-type-formatting nil)

;; LSP Java Integration
(use-package lsp-java)
(add-hook 'java-mode-hook #'lsp)
(setq lsp-java-jdt-download-url  "https://download.eclipse.org/jdtls/milestones/0.57.0/jdt-language-server-0.57.0-202006172108.tar.gz")

; LSP-UI
(use-package lsp-ui
  :config
  (setq lsp-ui-sideline-show-diagnostics t))

(global-set-key (kbd "C-c k") 'lsp-ui-doc-glance)

;; lsp ts-ls config
(setenv "PATH" (concat (getenv "PATH") ":/home/kenne/.config/nvm/versions/node/v20.18.0/bin"))
(add-to-list 'exec-path "/home/kenne/.config/nvm/versions/node/v20.18.0/bin")
(setq lsp-javascript-format-place-open-brace-on-new-line-for-control-blocks t)
(setq lsp-javascript-format-place-open-brace-on-new-line-for-functions t)

;; Ivy - Nice Completion & UI Changes
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package all-the-icons
  :if (display-graphic-p))


(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; (use-package rust-mode)

;; Which Key - command help on bottom of screen
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

; Company - code autocompletion
(use-package company)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   '("9c0412fcf6591a9e7a42d8c7198278d343ef70e872a05ad0b4d9a76b9cea082c" "4bcc839ae165e635ad488608a8627f63e3ee181c39accde2e738f1b08934108a" "c9bfd8f865ded457b4360b11409d0d363ebd01788f4853c3de9d3a64390ffe21" "4fc01050d7a0f29566e1b2ec7122cf7f9f5b9c139c36bc9f613343d6e32d587b" "27f94199c4b23953f86e06b7a016c8ba65df9ed25c9754a6c6a8214fbdfa8ac6" "b5c7f425e3b91c9f5f47b67109ea72c71e6d69ee61492401160703868a76aebc" "dd5bfa0716af6766672f1ca8357527e8f0af54a8a84a70b096d30fd5304f1f2b" "64c4f764cb676e9c54cb573d8be5b1e307bb7474f0b7a2d9fe79084f25bee79a" "4c7f0bd08fc9ae089a10c2c85758924d026390a2a2093a23597f771153d52207" "b63f253b05aaa41dddd1abb590e3097be5adfbbe44dbc966decc4125cf175fb6" "b5da51d5e284a7903b82f52b12d0c5abe282af2581b81e124b8d7cd8e41cad4d" "f6778f2058f1afa10daa5c99f04079d6c514f94a0a2896380fec52572fe6f7fa" "941fa4df0046c74740504dec558bdc88cbb93ece60986e3ff3a836326e94a190" "5c7593d38a6563f7d5dd46c9dcc2e5e010cf3ecdd58f4279d85b64731d9054b5" "5a5ba1c3c015a34b5da44a1916700f59317614cf03eba31ec089b747cb217581" "f60c026ec2a78b4c265dc809efdbdae86f0ac01d5368021d5fc12aaa43407d76" "b2c484de7cb05bbe64d94f16d4a2dd039378e6efe8fcd16afa34e1eb200f8e04" "127acb3002b93fd86476373c2ddb1ac1e7f93b11799ce91202bfdb20f69a0434" "4f982ad3706b8e173a837b3ba563e4f0705adcb23b39d05a1dd4d0ee0d4e6f8d" "9cd34b79e6508c949a11c5806755a8700835c596556174511c122f443f348c2b" "fad16789403cdca85b33af85b23e39416387e7d9b20b51ba6f6696893fc2e6c9" "9a2466098bd117d89bb5c878699d3ca7d57d2ece9c7aa12225fea0f2c7ae891a" "2be72b955f0654e6b8f632ba88f9f6abfc58daecefd2ea821767ea683e34efd2" "03766fa949b0a23f49974f69240003ff50d6e859a787dec7c9f06acdb1ab037f" "f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" default))
 '(fci-rule-color "#383838")
 '(ispell-dictionary nil)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(typescript-mode rust-mode lsp-java projectile hl-todo all-the-icons mood-line neotree adwaita-dark-theme marginalia company-glsl glsl-mode treemacs spinner counsel company which-key lsp-ui lsp-mode flycheck doom-modeline ivy))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((type tty) (min-colors 256)) (:background "black")))))
(global-company-mode)

;; Treemacs - graphical file tree
;; (use-package treemacs)


;; Neotree - graphical file tree
;; (use-package neotree)

;; (global-set-key (kbd "C-c C-j") 'treemacs-select-window)
;; (global-set-key (kbd "C-c C-j") 'neotree-toggle)


(use-package glsl-mode)
(use-package company-glsl
  :config
  (when (executable-find "glslangValidator")
    (add-to-list 'company-backends 'company-glsl)))

(use-package cmake-mode)

(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))

; Marginalia - explanations in m-x buffer
(use-package marginalia
  :init
  (marginalia-mode))


(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold)
	  ("SECTION" . "#FFFFFF")
	  ("IMPORTANT" . "#FF3333"))))
(hl-todo-mode)


; Custom c style so I don't have to deal with presets
(c-add-style "ryan"
	     '((c-basic-offset . 4)	; Guessed value
	       (c-offsets-alist
		(access-label . -)	; Guessed value
		(block-close . 0)	; Guessed value
		(class-close . 0)	; Guessed value
		(class-open . 0)	; Guessed value
		(defun-block-intro . +)	; Guessed value
		(defun-close . 0)	; Guessed value
		(defun-open . 0)	; Guessed value
		(else-clause . 0)	; Guessed value
		(inclass . +)		; Guessed value
		(innamespace . +)	; Guessed value
		(namespace-close . 0)	; Guessed value
		(namespace-open . 0)	; Guessed value
		(statement . 0)		; Guessed value
		(statement-block-intro . +) ; Guessed value
		(substatement-open . 0)	    ; Guessed value
		(topmost-intro . 0)	    ; Guessed value
		(annotation-top-cont . 0)
		(annotation-var-cont . +)
		(arglist-close . c-lineup-close-paren)
		(arglist-cont c-lineup-gcc-asm-reg 0)
		(arglist-cont-nonempty . c-lineup-arglist)
		(arglist-intro . +)
		(block-open . 0)
		(brace-entry-open . 0)
		(brace-list-close . 0)
		(brace-list-entry . 0)
		(brace-list-intro . +)
		(brace-list-open . 0)
		(c . c-lineup-C-comments)
		(case-label . +)
		(catch-clause . 0)
		(comment-intro . c-lineup-comment)
		(composition-close . 0)
		(composition-open . 0)
		(cpp-define-intro c-lineup-cpp-define +)
		(cpp-macro . -1000)
		(cpp-macro-cont . +)
		(do-while-closure . 0)
		(extern-lang-close . 0)
		(extern-lang-open . 0)
		(friend . 0)
		(func-decl-cont . +)
		(incomposition . +)
		(inexpr-class . +)
		(inexpr-statement . +)
		(inextern-lang . +)
		(inher-cont . c-lineup-multi-inher)
		(inher-intro . +)
		(inlambda . 0)
		(inline-close . 0)
		(inline . 0)
		(inline-open . 0)
		(inmodule . +)
		(knr-argdecl . 0)
		(knr-argdecl-intro . +)
		(label . 2)
		(lambda-intro-cont . +)
		(member-init-cont . c-lineup-multi-inher)
		(member-init-intro . +)
		(module-close . 0)
		(module-open . 0)
		(objc-method-args-cont . c-lineup-ObjC-method-args)
		(objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
		(objc-method-intro .
				   [0])
		(statement-case-intro . +)
		(statement-case-open . 0)
		(statement-cont . +)
		(stream-op . c-lineup-streamop)
		(string . -1000)
		(substatement-open . 0)
		(substatement . +)
		(substatement-label . 0)
		(template-args-cont c-lineup-template-args +)
		(topmost-intro-cont . c-lineup-topmost-intro-cont))))



(setq-default c-default-style "ryan")

;; Make Emacs in terminal background black


;; Code Folding config
(add-hook 'prog-mode-hook (lambda () (hs-minor-mode 1)))
(add-hook 'hs-minor-mode-hook
	  (lambda ()
	    (keymap-set hs-minor-mode-map "C-c C-j" 'hs-toggle-hiding)))


;; Ace window config - window switcher
(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
;; (ace-window-display-mode) ;; not compatible with "mood line"

;; Makes ace window work with html-mode
(add-hook 'html-mode-hook
          (lambda ()
            (keymap-set html-mode-map "M-o b" nil)
            (keymap-set html-mode-map "M-o d" nil)
            (keymap-set html-mode-map "M-o i" nil)
            (keymap-set html-mode-map "M-o l" nil)
            (keymap-set html-mode-map "M-o o" nil)
            (keymap-set html-mode-map "M-o e" nil)
            (keymap-set html-mode-map "M-o" 'ace-window)))

;; (eval-after-load 'neotree #'adwaita-dark-theme-neotree-configuration-enable)
;; (eval-after-load 'eldoc-frame #'adwaita-dark-theme-eldoc-frame-configuration-enable)
;; (adwaita-dark-theme-arrow-fringe-bmp-enable)
;; (eval-after-load 'flycheck #'adwaita-dark-theme-flycheck-fringe-bmp-enable)

;;; init ends here
