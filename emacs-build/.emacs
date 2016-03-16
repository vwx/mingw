(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(auto-save-interval 0)
 '(auto-save-timeout 0)
 '(blink-cursor-mode nil)
 '(browse-url-browser-function (quote browse-url-firefox))
 '(case-fold-search nil)
 '(column-number-mode t)
 '(current-language-environment "UTF-8")
 '(default-input-method "chinese-py-punct")
 '(desktop-save-mode t)
 '(display-time-mode t)
 '(global-font-lock-mode t nil (font-lock))
 '(global-hl-line-mode t)
 '(load-home-init-file t t)
 '(make-backup-files t)
 '(org-html-doctype "html5")
 '(org-html-use-unicode-chars t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(text-mode-hook (quote (text-mode-hook-identify)))
 '(tool-bar-mode nil nil (tool-bar))
 '(tooltip-mode nil nil (tooltip)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "wheat" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 163 :width normal :foundry "outline" :family "DejaVu Sans Mono")))))

;; English Font
;;(set-frame-font "DejaVu Sans Mono-20")
;;(set-default-font "DejaVu Sans Mono-20")
(setq initial-frame-alist '((top . 100) (left . 0)(width . 110) (height . 28)))
(setq default-frame-alist
      '((top . 100) (left . 100) (width . 110) (height . 28)
        (font . "DejaVu Sans Mono-16")))
(set-face-attribute 'default nil :font "DejaVu Sans Mono")

;; Chinese Font
;; (font-spec :family "WenQuanYi Zen Hei")
;; (font-spec :family "WenQuanYi Micro Hei Mono")
;; (font-spec :family "Microsoft Yahei UI Light")
(set-fontset-font "fontset-default"
                  'gb18030 '("PingFang SC Regular" . "unicode-bmp"))

(if (display-graphic-p)
    (dolist (charset '(han kana symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        (font-spec :family "PingFang SC Regular")))
  )
(setq face-font-rescale-alist
      '(("WenQuanYi Zen Hei" . 1.2)
        ("WenQuanYi Micro Hei Mono" . 1.2)
        ("PingFang SC" . 1.2)
        ("PingFang SC Regular" . 1.2)
        ("Microsoft Yahei UI" . 1.2)
        ))

(prefer-coding-system 'utf-8)
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

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

(fset 'yes-or-no-p 'y-or-n-p)
(transient-mark-mode t)
(column-number-mode t)
;;(display-time-mode t)

;; avoid jump to former paenthese 
(setq show-paren-mode 't)
(setq show-paren-style 'parentheses)	; seems does not work
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
 
(setq todo-file-do "~/.personal/todo-do")
(setq todo-file-done "~/.personal/todo-done")
(setq todo-file-top "~/.personal/todo-top")
  
(setq diary-file "~/.personal/diary")
(add-hook 'diary-hook 'appt-make-list)

(setq default-directory "~/")
(setq inhibit-startup-message t)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)

(show-paren-mode t)
(setq show-paren-style 'parentheses)

(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-off-auto-fill)

;;(setq make-backup-file nil)
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backup"))))
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq backup-by-copying t)

(setq kill-ring-max 200)

(setq uniquify-buffer-name-style 'forward)

(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(setq display-time-use-mail-icon t)
(setq display-time-interval 10)
(setq display-time-format "%04Y-%02m-%02d %02H:%02M:%02S")
(display-time)

(setq time-stamp-active t)
(setq time-stamp-warn-inactive t)
(setq time-stamp-format "%:y-%02m-%02d %3a %02H:%02M:%02S K.T")

(blink-cursor-mode -1)

;;dired config
(require 'dired)
(require 'dired-x)
(global-set-key "\C-x\C-j" 'dired-jump)
(define-key dired-mode-map "b" 'dired-mark-extension)
(define-key dired-mode-map "c" 'dired-up-directory)
(define-key dired-mode-map "e" 'dired-mark-files-containing-regexp)
(define-key dired-mode-map "o" 'chunyu-dired-open-explorer)
(define-key dired-mode-map "r" 'dired-mark-files-regexp)
(define-key dired-mode-map "/" 'dired-mark-directories)
(define-key dired-mode-map "K" 'dired-kill-subdir)
(define-key dired-mode-map [(control ?/)] 'dired-undo)

(defun explorer-dired ()
  (interactive)
  (let ((file-name (dired-get-file-for-visit)))
    (if (file-exists-p file-name)
        (w32-shell-execute "open" file-name nil 1))))

(setq dired-listing-switches "-avl" 
      dired-recursive-copies 'top 
      dired-recursive-deletes 'top
      cvs-dired-use-hook 'always) 

(setq default-fill-column 120)

(setq-default line-spacing 0.25)

(setq grep-find-command "find . \\( -name .svn -o -name .deps -o -name '*.o' -o -name '*.d' \\) -prune -o -type f -print0 | xargs -0 -e grep -n -e ")

(require 'recentf)
(recentf-mode t)

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(c-add-style "linux-kernel"
             '( "linux"
                (c-basic-offset . 8)
                (indent-tabs-mode . t)
                (tab-width . 8)
                (c-comment-only-line-offset . 0)
                (c-hanging-braces-alist
                 (brace-list-open)
                 (brace-entry-open)
                 (substatement-open after)
                 (block-close . c-snug-do-while)
                 (arglist-cont-nonempty))
                (c-cleanup-list brace-else-brace)
                (c-offsets-alist
                 (statement-block-intro . +)
                 (knr-argdecl-intro . 0)
                 (substatement-open . 0)
                 (substatement-label . 0)
                 (label . 0)
                 (statement-cont . +))
                ))
(add-hook 'c-mode-hook
	  '(lambda ()
	     (c-set-style "linux-kernel")
	     (gtags-mode 1)
	     )
	  )
(add-hook 'c++-mode-hook
	  '(lambda()
	     (c-set-style "gnu")
	     (gtags-mode 1)
	     )
	  )

(add-hook 'makefile-mode-hook
	  '(lambda()
             (setq indent-tabs-mode 1)
	     )
	  )
(add-hook 'makefile-gmake-mode-hook
	  '(lambda()
             (setq indent-tabs-mode 1)
	     )
	  )

(add-hook 'js-mode-hook
	  '(lambda()
             (setq indent-tabs-mode nil)
	     )
	  )
(setq c-default-style "gnu")

(add-hook 'org-mode-hook
          '(lambda()
             (setq truncate-lines nil)
             )
          )

(server-start)
