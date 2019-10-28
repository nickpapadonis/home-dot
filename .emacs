;; Set foreground and background
(set-foreground-color "green")
(set-background-color "black")

(add-to-list 'load-path "~/.emacs/lisp")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
;; If you want to use latest version
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; If you want to use last tagged version
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(xterm-mouse-mode)

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; default to unified diffs
(setq diff-switches "-u")

(defun track-mouse (e))

(setq mouse-wheel-follow-mouse 't)

(setq visible-bell 1)
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

;; (setq slime-lisp-implementations
;;      '((mit-scheme ("mit-scheme") :init mit-scheme-init)))
;; (setq slime-lisp-implementations
;;      '((cmucl ("cmucl" "-quiet"))
;;        (sbcl ("/opt/sbcl/bin/sbcl") :coding-system utf-8-unix)))

(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

(load "~/.emacs.d/lisp/geiser/geiser-load")

;; text completion framework
;; company-mode

;; for paredit
;;(load "~/.emacs.d/lisp/paredit.el")
;; M-x paredit-mode
;; M-( paredit-wrap-round, wraps around current S-expression
;; M=" paredit-wrap-quote
;; M-d paredit-forward-kill-word, advances into parenthsis and kills car
;; M-D paredit-backward-kill-word, same but from the back
;; C-d paredit-forward-delete, place at parenthsis and will delete eval from inner
;; C-k kills o the end of the current S-expr
;; paredit-forward paredit-backward, move in/out sexpression
;; paredit-forward-down paredit-backward-up, descent/ascent
;; paredit-forward-up   paredit-backward-down
;; splicing, splitting and joining...
;;(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
;;(add-hook 'M-mode-hook 'enable-paredit-mode)
;;(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;;(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;;(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
;;(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;;(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
;;(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

;;(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
;;
;;(defun override-slime-repl-bindings-with-paredit ()
;;  (define-key slime-repl-mode-map
    ;;    (read-kbd-macro paredit-backward-delete-key) nil
;;    ))
;;(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (racket-mode ac-slime ac-geiser auto-complete company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; C-. h on symbol for Scheme docs
(load-file "~/.emacs.d/lisp/r5rs.el")
(require 'r5rs)
(setq scheme-r5rs-root "~/info")
(global-set-key [(control ?.) ?h] 'scheme-r5rs-lookup)

(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))
