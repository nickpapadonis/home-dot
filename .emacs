(tool-bar-mode -1)
(setq inhibit-startup-message t)

;; Set foreground and background
(add-to-list 'default-frame-alist '(foreground-color . "green"))
(add-to-list 'default-frame-alist '(background-color . "black"))
(xterm-mouse-mode)
(setq visible-bell 1)
;; enable visual feedback on selections
(setq transient-mark-mode t)


;; ELPA Packaing System
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
;; If you want to use last tagged version
;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.d/elpa/")
;(let ((default-directory  "~/.emacs.d/lisp/"))
;  (normal-top-level-add-subdirs-to-load-path))

;(add-hook 'after-init-hook 'global-company-mode)

;; default to unified diffs
(setq diff-switches "-u")

(defun track-mouse (e))
(setq mouse-wheel-follow-mouse 't)

(setq column-number-mode t)

;;INFO
;; C-h S    over symbol
;; C-h TAB over symbol
(require 'info)
(require 'info-look)
(setq Info-directory-list
      (append '("~/info") '("/usr/share/info")
	      Info-directory-list))
(global-set-key (kbd "C-h TAB") 'info-lookup-symbol)

;; To quickly recompile
(global-set-key (kbd "C-c c") 'recompile)

;; (auto-complete-mode)
;; TAB, list RET
;; completion in geiser
(require 'ac-geiser)
(add-hook 'geiser-mode-hook 'ac-geiser-setup)
(add-hook 'geiser-repl-mode-hook 'ac-geiser-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'geiser-repl-mode))

;; completion in slime
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))

; (setq slime-lisp-implementations
;      '((mit-scheme ("mit-scheme") :init mit-scheme-init)))
;        (cmucl ("cmucl" "-quiet"))
;        (sbcl ("/opt/sbcl/bin/sbcl") :coding-system utf-8-unix))

(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

(require 'geiser)
;(setq geiser-mode-start-repl-p t)
;(setq geiser-active-implementations '(mit))

;; work around ksh print ^L when window is resized issue
;; Bug 40589 40732 40735
(setq window-adjust-process-window-size-function 'ignore)

(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (geiser slime racket-mode company ac-slime ac-geiser))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

