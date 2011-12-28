;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(add-to-list 'load-path "~/.emacs.d/emacs-bundle")
(add-to-list 'load-path "~/.emacs.d/emacs-deferred")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "~/.emacs.d/evil")
(add-to-list 'load-path "~/.emacs.d/evil-numbers")
(add-to-list 'load-path "~/.emacs.d/evil-surround")
(add-to-list 'load-path "~/.emacs.d/mythryl-mode")
(add-to-list 'load-path "~/.emacs.d/scala-mode")
(add-to-list 'load-path "~/.emacs.d/ensime/src/main/elisp")

(require 'deferred) ;; required by `emacs-bundle'
(require 'package) ;; required by `emacs-bundle'
(require 'evil)
(evil-mode 1)

(setq x-stretch-cursor t)
(global-hl-line-mode 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "monospace")))))

;; Ensime -------------------------------
(require 'mythryl-mode)
(require 'scala-mode)
(require 'ensime)

;; This step causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize this step
;; if you're not using the standard scala mode.
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; MINI HOWTO:
;; Open .scala file. M-x ensime (once per project)
;; ---- (end) Ensime --------------------


;; marmalade
;; @URL http://marmalade-repo.org/
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
