;; ⚔☠☃
;; Author: Jeffrey Lau <emacs@NOSPAMjlau.tk>
;;

;; DO WANT lexical-let pl0x
(eval-when-compile (require 'cl))
(eval-when-compile (require 'evil-numbers))

; custom ex commands, all DRY-ed up!
;;;###autoload
(mapc (lambda (ls)
        (eval
         `(progn
            (evil-define-command ,(cdar ls) ()
              ,(cadr ls)
              :repeat nil
              (interactive)
              ,(cddr ls)
              )
            (evil-ex-define-cmd
             ,(caar ls) ',(cdar ls)
             )
            )
         )
        )
      '(
        (("v"  . edit-init-el) .
         ("Switch to `init.el' for editing." . (v)))

        (("ve" . edit-custom-evil-stuff) .
         ("Switch to `evil-tk.jlau.el' for editing." . (find-file (e "evil-tk.jlau.el"))))

        (("vo" . edit-home-org) .
         ("Edit `~/org'." . (find-file (expand-file-name "org" "~"))))

        (("vc" . edit-custom-file) .
         ("Edit custom file." . (find-file (custom-file))))

        (("bs" . switch-to-scratch) .
         ("Switch to the *scratch* buffer." . (switch-to-buffer "*scratch*")))
        )
      )

;; bring back ^wq
;;;###autoload
(define-key evil-window-map "q" 'delete-window)

;; TODO: ^6?
;; only "\C-^" works, but not "\C-6"... :-(

;;;###autoload
(mapc (lambda (l)
        (define-key evil-normal-state-map (car l) (cdr l)
          )
        )
      `(
        ("ZZ"   . ":x")  ;; bring back ZZ & ZQ
        ("ZQ"   . ":q!")
        ("Zq"   . ":qa!")
        (,(kbd "C-a")   . evil-numbers/inc-at-pt) ;; evil numbers: bring back ^a & ^x
        (,(kbd "C-S-x") . evil-numbers/dec-at-pt)

        ;; simulate command-T & stuff (using iswitchb & icicles...)
        ;;(define-key evil-normal-state-map "\M-t" 'iswitchb-buffer)
        (",.b"  . iswitchb-buffer) ;; TODO: define using <leader>?
        (",.f"  . icicle-file)     ;; TODO: define using <leader>?
        )
      )

;;;###autoload
(mapc (lambda (l)
        (define-key evil-visual-state-map (car l) (cdr l)
          )
        )
      `(
        ;; Want smooth visual mode (de-)indentation!
        ;; where is vnoremap?!
        (,(kbd "C-,") . "<gv")
        (,(kbd "C-.") . ">gv")
        )
      )

;; bring back i_CTRL-H
;; @url https://github.com/cofi/dotfiles/blob/master/emacs.d/cofi-evil.el
;;;###autoload
(define-key evil-insert-state-map "\C-h" 'backward-delete-char)

;; delete parts of snake_case or camelCase words.
;; TODO: refine it!
;; @url https://slashusr.wordpress.com/2011/09/15/heretical-confessions-of-an-emacs-addict-joy-of-the-vim-text-editor/

;(evil-define-motion evil-little-word (count)
;  :type exclusive
;  (let ((case-fold-search nil))
;    (forward-char)
;    (search-forward-regexp "[_A-Z]\\|\\W" nil t)
;    (backward-char)))
;
;(define-key evil-operator-state-map "il" 'evil-little-word)

;;
;; Org mode bindings
;; @url https://github.com/cofi/dotfiles/blob/master/emacs.d/cofi-evil.el
;; @url http://stackoverflow.com/questions/8483182/emacs-evil-mode-best-practice
;;
;;;###autoload
(evil-declare-key 'normal org-mode-map
  (kbd "RET") 'org-open-at-point
  "za" 'org-cycle
  "zA" 'org-shifttab
  "zm" 'hide-body
  "zr" 'show-all
  "zo" 'show-subtree
  "zO" 'show-all
  "zc" 'hide-subtree
  "zC" 'hide-all
  )

;; Remap org-mode meta keys for convenience
;; Yeah... need to use backticks for evil's `evil-delay'...
;;;###autoload
(mapc (lambda (state)
          (eval `(evil-declare-key ',state org-mode-map
                   (kbd "C-t") 'org-todo
                   (kbd "M-l") 'org-metaright
                   (kbd "M-h") 'org-metaleft
                   (kbd "M-k") 'org-metaup
                   (kbd "M-j") 'org-metadown
                   (kbd "M-L") 'org-shiftmetaright
                   (kbd "M-H") 'org-shiftmetaleft
                   (kbd "M-K") 'org-shiftmetaup
                   (kbd "M-J") 'org-shiftmetadown)
                ))
        '(normal insert))

(provide 'evil-tk.jlau)
