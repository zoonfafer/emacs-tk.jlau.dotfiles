
;; set the root omg!
(setq eroot "~/.emacs.d")

;; LOL expand dat fiel naem easly!!!
(defun e (a &rest b)
  "expand path names from the concatenation of `eroot', A & B..."
  (expand-file-name (apply #'concat (cons a b)) eroot)
)

(global-hl-line-mode 1)
(global-linum-mode 1)
(iswitchb-mode 1)
;; DO NOT WANT start-up screen (which I can't coerce into use Evil mode)
;(setq initial-buffer-choice t) ;; now done in Customize

;; evil settings: must be done before `require'-ing evil
;(setq evil-shift-width 2) ;; customized
;(setq evil-want-C-u-scroll t) ;; why is the default `nil'? ;; customized

;; customize plz rite 2 dis fiel isnted pl0x
;; @url http://www.emacswiki.org/emacs/CustomizingBoth
(setq custom-file
      (e
       (if (featurep 'xemacs)
	   "x"
	 "")
       "emacs-customized.el"))
(load custom-file t)

;; easily open and edit this file
;;
;; FIXME: rename this `v' to a more meaningful name
(defun v () "quickly open init.el!" (find-file (e "init.el")))


;; Like `add-to-list', but cats the args instead.
(defun cat-to-list (a &rest b)
  "Add to A everything in B using `add-to-list'"
  (mapc (lambda (c) (add-to-list a c)) b)
  )

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (e "elpa/package.el"))
  (package-initialize))

;; marmalade
;; @URL http://marmalade-repo.org/
(cat-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))


;; load mah bundles!
;; @url http://stackoverflow.com/questions/221365/emacs-lisp-how-to-add-a-folder-and-all-its-first-level-sub-folders-to-the-load
(let* ((my-lisp-dir (e "bundles"))
       (default-directory my-lisp-dir)
       (orig-load-path load-path))
  (setq load-path (cons my-lisp-dir nil))
  (normal-top-level-add-subdirs-to-load-path)
  (nconc load-path orig-load-path))

;; Hmm...
(add-to-list 'load-path (e "."))

;; require mah bundles!
(mapc (lambda (a) (require a))
      '(
	deferred ;; required by `emacs-bundle'
	package  ;; required by `emacs-bundle'
	ecb
	evil
	evil-numbers
	evil-leader
	surround
	icicles
	flymake-jslint
	yasnippet
	js-tk.jlau
	evil-tk.jlau ;; load custom evil bindings
	)
      )

;; switch things on
(global-surround-mode 1)
(evil-mode 1)
;(icy-mode 1)
(yas/global-mode 1)

;; TODO: turn on yas minor mode at all times!
;; TODO: turn on evil minor mode at all times! (including ECB)

;; autoload each of these!
(mapc (lambda (a) (autoload a (symbol-name a) () t))
      '(
	mythryl-mode
	scala-mode
	ensime
	js2-mode
	)
      )

;; === Mythryl mode

;(require 'mythryl-mode)
;; for .pkg and .api files
(cat-to-list 'auto-mode-alist
	     '("\\.pkg\\'" . mythryl-mode)
	     '("\\.api\\'" . mythryl-mode)
	     )

;; for scripts starting with #!/.../mythryl
;; (add-to-list 'interpreter-mode-alist
(cat-to-list 'interpreter-mode-alist
	     '("mythryl" . mythryl-mode)
	     )

;; === Scala mode
;(require 'scala-mode)

;; Umm..., why is this not done already???/
(cat-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))

;; Ensime -------------------------------
;(require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook '(lambda () (yas/minor-mode-on)))

;; MINI HOWTO:
;; Open .scala file. M-x ensime (once per project)
;; ---- (end) Ensime --------------------

