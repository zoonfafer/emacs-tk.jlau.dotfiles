;; ⚔☠☃
;; Author: Jeffrey Lau <emacs@NOSPAMjlau.tk>
;;

;; DO WANT lexical-let pl0x
(eval-when-compile (require 'cl))
(eval-when-compile (require 'evil-numbers))

;;;###autoload
(evil-define-command edit-init-el ()
  "Switch to `init.el' for editing."
  :repeat nil
  (interactive)
  ;(find-file (expand-file-name "init.el" "~/.emacs.d")))
  (v))
;;;###autoload
(evil-ex-define-cmd "v" 'edit-init-el) ;; :v

;;;###autoload
(evil-define-command edit-custom-evil-stuff ()
  "Switch to `evil-tk.jlau.el' for editing."
  :repeat nil
  (interactive)
  ;(find-file (expand-file-name "evil-tk.jlau.el" "~/.emacs.d")))
  (find-file (e "evil-tk.jlau.el")))
;;;###autoload
(evil-ex-define-cmd "vc" 'edit-custom-evil-stuff) ;; :vc

;; map :bs to switch to the scratch buffer
;;;###autoload
(evil-define-command switch-to-scratch ()
  "Switch to the *scratch* buffer."
  :repeat nil
  (interactive)
  (switch-to-buffer "*scratch*"))
(evil-ex-define-cmd "bs" 'switch-to-scratch) ;; :bs

;; bring back ^wq
;;;###autoload
(define-key evil-window-map "q" 'delete-window)

;; TODO: :b#?  ^6?
;; @url http://www.emacswiki.org/emacs/SwitchingBuffers
;;;###autoload
(defun switch-to-previous-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;;;###autoload
(evil-ex-define-cmd "bb" 'switch-to-previous-buffer) ;; :bb

;;;###autoload
(define-key evil-normal-state-map "\C-^" 'switch-to-previous-buffer) ;; no \C-6 ... :(

;; bring back ZZ & ZQ
;
;;;###autoload
(define-key evil-normal-state-map "ZZ" ":x")

;;;###autoload
(define-key evil-normal-state-map "ZQ" ":q!")

;; bring back i_CTRL-H
;; @url https://github.com/cofi/dotfiles/blob/master/emacs.d/cofi-evil.el
;;;###autoload
(define-key evil-insert-state-map "\C-h" 'backward-delete-char)

;; evil numbers: bring back ^a & ^x
;;;###autoload
(define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)


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

;; simulate command-T & stuff (using iswitchb & icicles...)
;(define-key evil-normal-state-map "\M-t" 'iswitchb-buffer)
;
;;;###autoload
(define-key evil-normal-state-map ",.b" 'iswitchb-buffer) ;; TODO: define using <leader>?

;;;###autoload
(define-key evil-normal-state-map ",.f" 'icicle-file) ;; TODO: define using <leader>?

;; TODO: jump to default org mode file!

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
;;;###autoload
(mapc (lambda (state)
         (lexical-let ((state state))
           (evil-declare-key state org-mode-map
             (kbd "C-t") 'org-todo
             (kbd "M-l") 'org-metaright
             (kbd "M-h") 'org-metaleft
             (kbd "M-k") 'org-metaup
             (kbd "M-j") 'org-metadown
             (kbd "M-L") 'org-shiftmetaright
             (kbd "M-H") 'org-shiftmetaleft
             (kbd "M-K") 'org-shiftmetaup
             (kbd "M-J") 'org-shiftmetadown)
           )
         )
      '(normal insert))

(provide 'evil-tk.jlau)