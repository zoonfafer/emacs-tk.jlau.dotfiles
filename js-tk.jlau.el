;; copied & modified from emacs-starter-kit
;; @url https://github.com/technomancy/emacs-starter-kit

;;;###autoload
(add-to-list 'auto-mode-alist
	     '("\\.js\\'" . js2-mode)
	     )

;;;###autoload
(eval-after-load 'js
  '(progn (setq js-indent-level 2)
          ;; fixes problem with pretty function font-lock
          (define-key js-mode-map (kbd ",") 'self-insert-command)
          (font-lock-add-keywords
           'js2-mode `(("\\(function *\\)("
                       (0 (progn (compose-region (match-beginning 1)
                                                 (match-end 1) "\u0192")
                                 nil)))))))

;; @url http://www.emacswiki.org/emacs/FlymakeJavaScript
;; @url http://lapin-bleu.net/riviera/?p=191
;;;###autoload
(add-hook 'javascript-mode-hook
	  (lambda () (flymake-mode 1)))

(provide 'js-tk.jlau)