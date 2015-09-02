;; Some usefile modes.
(add-hook 'f90-mode-hook 'auto-complete-mode)
(add-hook 'f90-mode-hook 'auto-revert-mode)

;; Add proper comments for f90 mode.
(add-hook 'f90-mode-hook
	  (lambda ()
	    (setq comment-start "!> ")
	    (setq comment-continue "!> ")))

;; Some style.
(setq f90-auto-keyword-case 'downcase-word)

;; The cleanup function.
(defun f90-cleanup-style (&optional start end)
  "Run some cleanup actions on a Fortran file."
  (interactive (progn
                 (barf-if-buffer-read-only)))
  (message "Cleaning up Fortran style...")
  (f90-replace-regexp "else[ \t]*if" "else if")
  (cl-loop for k in '("associate"
                      "do while"
                      "do"
                      "if"
                      "result"
                      "select case"
                      "select type"
                      "where")
           collect (f90-replace-regexp (format "%s[ \t]*([ \t]*" k) (format "%s(" k)))
  (cl-loop for k in '("associate"
                      "do"
                      "if"
                      "select"
                      "while")
           collect (f90-replace-regexp (format "[^#]end%s" k) (format "end %s" k)))
  (save-excursion
    (goto-char (point-min))
    (cl-loop until (eobp) do (indent-for-tab-command) (forward-line 1)))
  (delete-trailing-whitespace)
  (display-message-or-buffer "Done with cleaning"))

;; regex replace in buffer.
(defun f90-replace-regexp (regex replacement)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward regex nil t)
      (replace-match replacement nil nil))))
