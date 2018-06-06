(defun underline-text (arg)
  "Inserts a line under the current line, filled with a default
underline character `='. If point had been at the end of the
line, moves point to the beginning of the line directly following
the underlining. It does not underline the line's leading
whitespace, trailing whitespace, or comment symbols. With prefix `C-u'
prompts user for a custom underline character. With prefix `C-u
C-u', does not underline whitespace embedded in the line."

  ; Copyright 2015 Boruch Baum <boruch_baum@gmx.com>, GPL3+ license
  (interactive "p")
  (let* ((original-point (point))
         (underline-char
           (replace-regexp-in-string "[[:cntrl:][:space:]]" "="
           (if (= arg 1)
               "="
             (char-to-string
           (read-char "What character to underline with?")))))
         (original-point-is-eol
           (when (looking-at "$") t))
         (original-point-is-eob
           (= original-point (point-max))))
    (beginning-of-line)
    (unless
      (when (looking-at "[[:space:]]*$")
        (beginning-of-line 0)
        (when (looking-at "[[:space:]]*$")
          (goto-char original-point)
          (message "nothing to do")))
      (insert
        (buffer-substring (line-beginning-position) (line-end-position))
        "\n")
      (save-restriction
        (narrow-to-region
          (progn
            (goto-char (1- (re-search-forward "[^[:space:]]" nil t)))
            (cond
              ((looking-at ";+")   (match-end 0))
              ((looking-at "#+")   (match-end 0))
              ((looking-at "//+")  (match-end 0))
              ((looking-at "/\\*+") (match-end 0))
              (t (point))))
          (1+ (progn
        (goto-char (line-end-position))
            (re-search-backward "[^[:space:]]" nil t))))
        (untabify (point-min) (point-max))
        (goto-char (point-min))
        (if (= arg 16)
          (while (re-search-forward "[^[:space:]]" nil t)
            (replace-match underline-char nil))
         (re-search-forward "[^[:space:]]" nil t)
         (goto-char (1- (point)))
         (while (re-search-forward "." nil t)
           (replace-match underline-char nil)))
        (widen))
      (if original-point-is-eob
        (goto-char (point-max))
       (if original-point-is-eol
         (goto-char (re-search-forward "^"))
        (goto-char original-point))))))

(provide 'smark)
