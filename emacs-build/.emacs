(require 'package)
(setq package-enable-at-startup nil)

(unless (assoc-default "gnu" package-archives)
  (add-to-list 'package-archives '("gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")))
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t))
(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/") t))
(package-initialize)

;; Install use-package if not available
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-verbose t)
(setq use-package-always-ensure t)
(setq warning-minimum-level :emergency)

(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setenv "LANG" "en_US.UTF-8")
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LC_CTYPE" "en_US.UTF-8")
(setenv "LC_COLLATE" "zh_CN.UTF-8")
(setq-default buffer-file-coding-system 'utf-8)
(setq-default default-buffer-file-coding-system 'utf-8)
(when (eq system-type 'windows-nt)
  (set-next-selection-coding-system 'utf-16-le)
  (set-selection-coding-system 'utf-16-le)
  (set-clipboard-coding-system 'utf-16-le)
  )
(when (eq system-type 'windows-nt)
  (setenv "PATH"
          (concat
           (expand-file-name "D:/GNU/msys2/usr/bin/")
           path-separator
           (getenv "PATH")))
  ;; Prevent issues with the Windows null device (NUL)
  ;; when using msys find with rgrep.
  (defadvice grep-compute-defaults (around grep-compute-defaults-advice-null-device)
    "Use /dev/null as the null-device."
    (let ((null-device "/dev/null"))
      ad-do-it))
  (ad-activate 'grep-compute-defaults)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-save-default nil)
 '(auto-save-interval 0)
 '(auto-save-timeout 0)
 '(blink-cursor-mode nil)
 '(browse-url-browser-function 'browse-url-firefox)
 '(case-fold-search nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes '(modus-operandi))
 '(custom-safe-themes
   '("18c5ec0e4d1723dbeadb65d17112f077529fd24261cb8cd4ceee145e6a6f4cd1" default))
 '(default-input-method "chinese-py-punct")
 '(desktop-save-mode t)
 '(display-time-mode t)
 '(global-font-lock-mode t)
 '(global-hl-line-mode t)
 '(js-indent-level 4)
 '(js-switch-indent-offset 4)
 '(load-home-init-file t t)
 '(make-backup-files nil)
 '(org-html-doctype "html5")
 '(org-html-use-unicode-chars t)
 '(package-selected-packages
   '(## company lsp-python-ms lsp-mode typescript-mode ahk-mode))
 '(php-mode-coding-style 'psr2)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(text-mode-hook '(text-mode-hook-identify))
 '(tool-bar-mode nil nil (tool-bar))
 '(tooltip-mode nil)
 '(typescript-indent-level 2)
 '(typescript-mode-hook nil t))


(display-battery-mode t)
(toggle-scroll-bar nil)
(global-auto-revert-mode t)

(fset 'yes-or-no-p 'y-or-n-p)
;;(toggle-frame-fullscreen)

(setq tab-width 8
      inhibit-splash-screen t
      initial-scratch-message nil
      sentence-end-double-space nil
      make-backup-files nil
      indent-tabs-mode nil
      make-backup-files nil
      auto-save-default nil)
(setq create-lockfiles nil)

(unless (display-graphic-p)
  (progn
    (setq gc-cons-threshold (* 8192 8192))
    (setq read-process-output-max (* 1024 1024 128)) ;; 128MB
    ))

(setq use-default-font-for-symbols nil)
(set-frame-font "Source Code Pro-16")
(when (display-graphic-p)
  (setq fonts
        (cond ((eq system-type 'gnu/linux) '("Cascadia Mono" "HYXuanSong"))
              ((eq system-type 'windows-nt) '("Source Code Pro" "Noto Sans Mono CJK SC"))))
  (setq face-font-rescale-alist
        '(("HYQiHei" . 1.2)
          ("HYXuanSong" . 1.2)
          ("Microsoft YaHei UI" . 1.2)
          ("Microsoft YaHei UI Light" . 1.2)
          ("Noto Sans CJK SC" . 1.2)
          ("Noto Sans Mono CJK SC" . 1.2)
          ("Noto Serif CJK SC" . 1.2)
          ("Source Han Sans SC" . 1.2)
          ("Source Han Sans Mono SC" . 1.2)
          ("Source Han Serif SC" . 1.2)
          ))
  (set-face-attribute 'default nil :font (car fonts))
  (dolist (charset '(kana han cjk-misc hangul kanbun bopomofo cyrillic))
    ;;(set-fontset-font (frame-parameter nil 'font) charset
    ;;                  (font-spec :family (car (cdr fonts))))
    (set-fontset-font "fontset-default" charset
                      (font-spec :family (car (cdr fonts))))
    )
  ;;‘’“”
  (dolist (charset '((#x2018 . #x2019)
                     (#x201c . #x201d)
                     (#x2025 . #x2026)
                     (#x2000 . #x206F)
                     ))
    (set-fontset-font "fontset-default" charset
                      ;;; (font-spec :family (car (cdr fonts)))
                      (font-spec :family "Noto Sans Mono CJK SC")
                      )
    )
  )

(use-package recentf
  :config
  (progn
    (setq recentf-max-saved-items 200
          recentf-max-menu-items 15)
    (recentf-mode)
    ))

(use-package json-mode)

(setq org-todo-keywords 
      '((sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "REVIEW(r)" "|" "DONE(d)" "CANCELED(c)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning)
        ("INPROGRESS" . "yellow")
        ("WAITING" . "purple")
        ("REVIEW" . "orange")
        ("DONE" . "green")
        ("CANCELED" .  "red")))

(when (display-graphic-p)
  (progn
    (setq initial-frame-alist
          '(
            (tool-bar-lines . 0)
            (width . 100)
            (height . 25)
            (background-color . "#eeeeee")
            (foreground-color . "#363636")
            (left . 50)
            (top . 50)
            )
          )
    (setq default-frame-alist
          '(
            (tool-bar-lines . 0)
            (width . 100)
            (height . 25)
            (background-color . "#fefefe")
            (foreground-color . "#363636")
            (left . 50)
            (top . 50)
            )
          )
    )
  )


(setq system-time-locale "C")
;; Show buffer name in title
(setq frame-title-format
      '((buffer-file-name "%f"
			  (dired-directory dired-directory "%b"))))

(setq inhibit-startup-message t)
(setq column-number-mode t)
(setq mouse-yank-at-point t)
(setq show-paren-style 'parentheses)
(setq dired-kept-versions 1)

(cond 
 (
  (fboundp 'global-font-lock-mode)
  ;; Turn on font-lock in all modes that support it
  (global-font-lock-mode t)
  ;; Maximum colors
  (setq font-lock-maximum-decoration t)
  )
 )

(transient-mark-mode t)

;; avoid jump to former paenthese 
(setq show-paren-mode t)
;; avoid jump when scrolling
(setq scroll-setp 1
      scroll-margin 0
      scroll-conservatively 10000
      )
;; auto show image
(auto-image-file-mode)

;; big file highligh too slow;
(setq lazy-lock-defer-on-scrolling t)
;;(setq font-lock-support-mode '((t . lazy-lock-mode)))
(setq font-lock-maximum-decoration t)
;; auto complete function
(global-set-key "\M- " 'hippie-expand)
(setq hippie-expand-try-functions-list 
      '(try-complete-file-name-partially 
	try-complete-file-name 
	try-expand-all-abbrevs 
	try-expand-list 
	try-expand-line 
	try-expand-dabbrev 
	try-expand-dabbrev-all-buffers 
	try-expand-dabbrev-from-kill 
	try-complete-lisp-symbol-partially 
	try-complete-lisp-symbol)
      ) 

(setq default-directory "~/")
(setq inhibit-startup-message t)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(show-paren-mode t)
(setq show-paren-style 'parentheses)

(setq default-major-mode 'text-mode)

(setq kill-ring-max 200)

(setq uniquify-buffer-name-style 'forward)

(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 1)
(setq display-time-format "%04Y-%02m-%02d %02H:%02M:%02S")
(display-time)

(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
(setq time-stamp-format "%:y-%02m-%02d %3a %02H:%02M:%02S K.T")

(setq default-fill-column 120)
(setq-default line-spacing 0.25)

(setq grep-find-command "find . \\( -name .svn -o -name .deps -o -name '*.o' -o -name '*.d' \\) -prune -o -type f -print0 | xargs -0 -e grep -n -e ")

(setq-default indent-tabs-mode nil)
(add-hook 'text-mode-hook 'turn-off-auto-fill)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'makefile-mode-hook
	  (lambda()
             (setq indent-tabs-mode 1)
	     )
	  )
(add-hook 'makefile-gmake-mode-hook
	  (lambda()
             (setq indent-tabs-mode 1)
	     )
	  )

(add-hook 'js-mode-hook
	  (lambda()
             (setq indent-tabs-mode nil)
	     )
	  )

(add-hook 'org-mode-hook
          (lambda()
             (setq truncate-lines nil)
             )
          )

(add-hook 'typescript-mode-hook
          (lambda()
             'lsp
             )
          )

(add-hook 'html-mode-hook
          (lambda ()
            ;; Default indentation is usually 2 spaces, changing to 1.
            (set (make-local-variable 'sgml-basic-offset) 1)
            )
          )


(add-hook 'sgml-mode-hook
          (lambda ()
            ;; Default indentation to 1, but let SGML mode guess, too.
            (set (make-local-variable 'sgml-basic-offset) 1)
            (sgml-guess-indent)
            )
          )

(modify-coding-system-alist 'file "" 'utf-8)

;;(setq python-indent-offset 4)
(setq python-indent-guess-indent-offset nil)


(load "server")
(unless (server-running-p)
  (server-start))

(require 'recentf)
(recentf-mode t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package company
  :ensure t
  :init (global-company-mode))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (typescript-mode . lsp-deferred)
         (javascript-mode . lsp-deferred)
         )
  :commands (lsp lsp-deferred)
  )



(eval-after-load 'lsp-mode
  '(progn
     ;; enable log only for debug
     (setq lsp-log-io nil)
     ;; use `evil-matchit' instead
     (setq lsp-enable-folding nil)
     ;; no real time syntax check
     (setq lsp-prefer-flymake :none)
     ;; don't scan some files
     (push "[/\\\\][^/\\\\]*\\.json$" lsp-file-watch-ignored) ; json
     ;; don't ping LSP lanaguage server too frequently
     (defvar lsp-on-touch-time 0)
     (defadvice lsp-on-change (around lsp-on-change-hack activate)
       ;; don't run `lsp-on-change' too frequently
       (when (> (- (float-time (current-time))
                   lsp-on-touch-time) 30)
         ;; 30 seconds
         (setq lsp-on-touch-time (float-time (current-time)))
         ad-do-it))
     )
  )

