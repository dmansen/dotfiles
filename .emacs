
; load path section
(add-to-list 'load-path "~/.elisp")
(add-to-list 'load-path "~/.elisp/haskell-mode")
(add-to-list 'load-path "~/.elisp/fuzzy-find-in-project")
(add-to-list 'load-path "~/opt/clojure-mode")
(add-to-list 'load-path "~/opt/slime")
(add-to-list 'load-path "~/.elisp/full-ack")

; require section
(require 'slime)
(require 'fuzzy-find-in-project)
(require 'ido)
(require 'haskell-mode)
(require 'inf-haskell)
(require 'clojure-mode)
(require 'paredit)
(require 'custom)

;; slime
(eval-after-load "slime" 
  '(progn (slime-setup '(slime-repl))
          (defun paredit-mode-enable () 
            (paredit-mode 1)
            (local-set-key (kbd "M-[ c") 'paredit-forward-slurp-sexp)
            (local-set-key (kbd "M-[ d") 'paredit-backward-slurp-sexp))
          (add-hook 'slime-mode-hook 'paredit-mode-enable)
          (add-hook 'slime-repl-mode-hook 'paredit-mode-enable)
          (setq slime-protocol-version 'ignore)))

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

(slime-setup)

; haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook (lambda ()
	(setq tab-width 2)
	(setq indent-tabs-mode nil)))

; ack
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

; need this because 'ack' is something different in ubuntu
(setq ack-executable (executable-find "ack-grep"))

; fuzzy find files and grep file commands
(fuzzy-find-project-root "~/code/clojure")

(global-set-key (kbd "C-x C-n") 'fuzzy-find-in-project)
(global-set-key (kbd "C-x C-a") 'ack)
; easier way of doing M-x
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-c C-m") 'execute-extended-command)
; M-TAB doesn't work with alt-tab!
(global-set-key (kbd "C-c C-c") 'completion-at-point)

; split window vertically by default
(setq split-height-threshold 0)
(setq split-width-threshold 0)

; tab stuff
(setq default-tab-width 2)
(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)

; always have word wrap on
(toggle-truncate-lines)

; use chrome to browse urls
(setq browse-url-generic-program (executable-find "google-chrome") browse-url-browser-function 'browse-url-generic)

; ido settings
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

; don't pollute directories with backup files...instead, but them
; into .emacs-backup
(defvar user-temporary-file-directory
  "~/.emacs-backup/")
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

; no menus
(tool-bar-mode -1)
(menu-bar-mode 0)

(load-theme 'tango-dark)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(clean-buffer-list-delay-general 1)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-file "~/.elisp/geiser/elisp/geiser.el")
(require 'uniquify)
