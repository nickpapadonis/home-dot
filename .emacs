(defun tb ()
  (setq tab-width 4)
  )

(setq whitespace-style '(trailing tabs newline tab-mark newline-mark))
;; work around ksh print ^L when window is resized issue
;; Bug 40589 40732 40735
(setq window-adjust-process-window-size-function 'ignore)
