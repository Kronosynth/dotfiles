;; save / load emacs sessions

(desktop-save-mode)
(add-hook 'desktop-after-read-hook 'powerline-reset)

;; start the emacs server

(server-start)
(package-initialize)

;; no menu-bar, toolbar or scroll bar

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Window title for topbar.

;; (setq frame-title-format
;;   '("xi: " (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; clean *scratch*, no more startup screen.

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; truncate lines

(setq truncate-partial-width-windows t)

;; Add column number and buffer size to modeline

(column-number-mode 1)
(size-indication-mode 1)

;; no restrictions

(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)

;; yes-or-no --> y-or-n, kill-line --> kill-whole-line

(defalias 'yes-or-no-p 'y-or-n-p)
(setq kill-whole-line t)

;; highlight brackets

(show-paren-mode t)
(setq show-paren-style 'expression)

;; Delete selected text on typing

(delete-selection-mode)

;; Focus follows mouse, inform emacs that my xmonad does the same.

(setq focus-follows-mouse t)
(setq mouse-autoselect-window t)

;; Scrolling

(setq scroll-margin 5)
(setq scroll-conservatively 5)
(setq scroll-error-top-bottom nil)
(setq scroll-preserve-screen-position t)

(eval-after-load "comint"
  '(add-to-list 'comint-mode-hook
     (lambda () (set (make-local-variable 'scroll-margin) 0))))

;; Echo keystrokes faster

(setq echo-keystrokes 0.1)

;; Backups

(setq backup-by-copying t)
(setq backup-directory-alist '(("." . "~/.emacs.d/.saves")))
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)
(setq version-control t)



;; Extra help

(require 'help+)
(require 'help-fns+)
(require 'help-mode+)

;; Add line numbers to programming buffers, highlight indentation and
;; colorize their colour codes.

;; (require 'indent-guide)

(add-hook 'prog-mode-hook 'nlinum-mode)
;; (add-hook 'prog-mode-hook 'indent-guide-mode)
(add-hook 'prog-mode-hook 'rainbow-mode)

(eval-after-load 'rainbow-mode '(diminish 'rainbow-mode))
(eval-after-load 'indent-guide '(diminish 'indent-guide-mode))

;;;; Modify emacs-lisp-mode to accept - as part of a word
;; (modify-syntax-entry ?- "w" emacs-lisp-mode-syntax-table)

;; Undo-tree mode, make it global, diminish it from modelines.

(global-undo-tree-mode)
(diminish 'undo-tree-mode)

;; Auctex

(set-default 'preview-scale-function 1.2)

;; Ido mode and all associated paraphernalia

(ido-mode)

(add-hook 'ido-setup-hook 'ido-my-keys)
(defun ido-my-keys ()
  (define-key ido-completion-map (kbd "TAB") 'ido-next-match)
  (define-key ido-completion-map [S-iso-lefttab] 'ido-prev-match))

(flx-ido-mode)
(ido-vertical-mode)
(ido-ubiquitous-mode)
(ido-at-point-mode)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-faces nil)

(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'execute-extended-command)

(setq smex-prompt-string ">>= ")

;; Configure package archives

(setq package-archives '(("elpa" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(define-key package-menu-mode-map "/" 'evil-search-forward)
(define-key package-menu-mode-map "n" 'evil-search-next)
(define-key package-menu-mode-map "N" 'evil-search-previous)

(define-key package-menu-mode-map "j" 'next-line)
(define-key package-menu-mode-map "k" 'previous-line)

;; Registers!

(set-register ?e '(file . "~/.emacs"))
(set-register ?g '(file . "~/.ghci"))
(set-register ?o '(file . "~/.ocamlinit"))
(set-register ?m '(file . "~/.xmonad/xmonad.hs"))
(set-register ?b '(file . "~/.bashrc"))
(set-register ?c '(file . "~/.xmonad/.conky_dzen"))
(set-register ?v '(file . "~/.vimperatorrc"))
(set-register ?z '(file . "~/.zshrc"))
(set-register ?i '(file . "~/.xinitrc"))
(set-register ?d '(file . "~/.Xdefaults"))

(set-register ?t '(file . "~/todo.navi"))

;; Set auto-mode-alist for various modes and autload others

(setq auto-mode-alist
   (append '(("\\.h\\'" . c++-mode)
             ("\\.rkt\\'" . scheme-mode)
             ("\\.pl\\'" . prolog-mode)
             ("\\.service\\'" . conf-mode)
             ("\\.ocamlinit\\'" . tuareg-mode)) auto-mode-alist))

;; Set up haskell-mode

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)
(add-hook 'haskell-mode-hook 'inf-haskell-mode)
(add-hook 'haskell-mode-hook 'hindent-mode)

(eval-after-load "haskell-indentation" '(diminish 'haskell-indentation-mode))
(eval-after-load "inf-haskell" '(diminish 'inf-haskell-mode))
(eval-after-load "hindent" '(diminish 'hindent-mode))

(add-hook 'flycheck-mode-hook 'flycheck-haskell-setup)

(setq haskell-tags-on-save t)

;; Ibuffer

(global-set-key (kbd "C-x C-b") 'ibuffer)

(eval-after-load "ibuffer"
  '(progn (define-key ibuffer-mode-map "j" 'ibuffer-forward-line)
          (define-key ibuffer-mode-map "k" 'ibuffer-backward-line)
          (define-key ibuffer-mode-map "J" 'ibuffer-jump-to-buffer)
          (define-key ibuffer-mode-map "n" 'ido-switch-buffer)
          (define-key ibuffer-mode-map (kbd "C-k") 'ido-switch-buffer)

          (define-key ibuffer-mode-map (kbd "C-x C-f") 'ido-find-file)
          (define-key ibuffer-mode-map (kbd "C-x b") 'ido-switch-buffer)))

;; Magit

;; (eval-after-load "magit"
;;   '(progn
;;      (define-key magit-status-mode-map "j" 'magit-section-forward)
;;      (define-key magit-status-mode-map "k" 'magit-section-backward)
;;      (define-key magit-status-mode-map "n" 'magit-section-jump-map)
;;      (define-key magit-status-mode-map "p" 'magit-discard-item)
;;      (define-key magit-status-mode-map (kbd "C-k") 'magit-discard-item)

;;      (define-key magit-log-mode-map "j" 'magit-section-forward)
;;      (define-key magit-log-mode-map "k" 'magit-section-backward)

;;      (define-key magit-commit-mode-map "j" 'magit-goto-next-section)
;;      (define-key magit-commit-mode-map "k" 'magit-goto-previous-section)
;;      (define-key magit-commit-mode-map "n" 'magit-jump-to-diffstats)

;;      (add-hook 'magit-status-mode-hook 'magit-filenotify-mode)
;;      (add-hook 'magit-status-mode-hook 'magit-filenotify-mode)
;;      ))

;; ARFF mode definition for working with weka

(require 'generic)
(define-generic-mode 'arff-file-mode
  (list ?%)
  (list "attribute" "relation" "end" "data")
  '(("\\('.*'\\)" 1 'font-lock-string-face)
    ("^\\@\\S-*\\s-\\(\\S-*\\)" 1 'font-lock-string-face)
    ("^\\@.*\\(real\\)" 1 'font-lock-type-face)
    ("^\\@.*\\(integer\\)" 1 'font-lock-type-face)
    ("^\\@.*\\(numeric\\)" 1 'font-lock-type-face)
    ("^\\@.*\\(string\\)" 1 'font-lock-type-face)
    ("^\\@.*\\(date\\)" 1 'font-lock-type-face)
    ("^\\@.*\\({.*}\\)" 1 'font-lock-type-face)
    ("^\\({\\).*\\(}\\)$" (1 'font-lock-reference-face) (2 'font-lock-reference-face))
    ("\\(\\?\\)" 1 'font-lock-reference-face)
    ("\\(\\,\\)" 1 'font-lock-keyword-face)
    ("\\(-?[0-9]+?.?[0-9]+\\)" 1 'font-lock-constant-face)
    ("\\(\\@\\)" 1 'font-lock-preprocessor-face))
  (list "\.arff?")
  (list
   (function
    (lambda ()
      (setq font-lock-defaults (list 'generic-font-lock-defaults nil t ; case insensitive
                                     (list (cons ?* "w") (cons ?- "w"))))
      (turn-on-font-lock))))
  "Mode for arff-files.")

;; Flycheck

(global-flycheck-mode)

(eval-after-load "flycheck"
  '(progn
     (define-key flycheck-error-list-mode-map "j" 'flycheck-error-list-next-error)
     (define-key flycheck-error-list-mode-map "k" 'flycheck-error-list-previous-error)))

(defun flycheck-status ()
  (interactive)
  (flycheck-list-errors)
  (other-window 1))

;;;;; Evil mode, extensions and powerline to go with it

(evil-mode)
(global-evil-surround-mode)
(evilnc-default-hotkeys)

(add-to-list 'load-path "~/.emacs.d/powerline/")
(require 'powerline)
(powerline-evil-theme)
(setq evil-emacs-state-tag " E "
      evil-normal-state-tag " N "
      evil-insert-state-tag " I "
      evil-visual-state-tag " V "
      evil-motion-state-tag " M "
      evil-replace-state-tag " R "
      evil-operator-state-tag " O ")

(setq evil-symbol-word-search t)

;;;; Evil modes

(add-to-list 'evil-insert-state-modes 'inferior-haskell-mode)
(add-to-list 'evil-insert-state-modes 'idris-repl-mode)
(add-to-list 'evil-insert-state-modes 'tuareg-interactive-mode)
(add-to-list 'evil-insert-state-modes 'with-editor-mode)

;; (delete 'ibuffer-mode evil-emacs-state-modes)
;; (evil-define-key 'normal ibuffer-mode-map
;;   "J" 'ibuffer-jump-to-buffer)

;; (evil-make-overriding-map package-menu-mode-map 'normal)
;; (delete 'package-menu-mode evil-emacs-state-modes)

;;;; Evil keys and functions

;; Flippping i and a

(define-key evil-normal-state-map (kbd "s") 'evil-surround-region)

;; (define-key evil-motion-state-map [S-iso-lefttab] 'evil-jump-backward)

;; (define-key evil-normal-state-map (kbd "gf") 'ido-find-file)
;; (define-key evil-normal-state-map (kbd "gb") 'ido-switch-buffer)

(define-key evil-motion-state-map (kbd "C-j") 'evil-scroll-page-down)
(define-key evil-motion-state-map (kbd "C-k") 'evil-scroll-page-up)

(define-key evil-normal-state-map (kbd ",m") 'magit-status)
(define-key evil-normal-state-map (kbd ",g") 'magit-status)
(define-key evil-normal-state-map (kbd ",f") 'flycheck-status)
(define-key evil-normal-state-map (kbd ",F") 'flycheck-previous-error)

(defun diff-this-buffer-with-file ()
  (interactive)
  (diff-buffer-with-file (current-buffer)))

(define-key evil-normal-state-map (kbd ",?") 'diff-this-buffer-with-file)

(define-key evil-normal-state-map (kbd "U") 'undo-tree-visualize)


(define-key evil-motion-state-map (kbd "C-j") 'evil-scroll-page-down)
(define-key evil-motion-state-map (kbd "C-k") 'evil-scroll-page-up)

;; (define-key evil-normal-state-map (kbd "C-b") 'ibuffer)

(define-key evil-normal-state-map (kbd "<S-return>")
  (lambda (&optional arg) (interactive "P")
    (evil-open-above arg)
    (evil-normal-state)))

(define-key evil-normal-state-map (kbd "RET")
  (lambda (&optional arg) (interactive "P")
    (evil-open-below arg)
    (evil-normal-state)))

(setq evil-ace-jump-active t)

(define-key evil-motion-state-map (kbd "SPC") 'evil-ace-jump-word-mode)
(define-key evil-motion-state-map (kbd "C-SPC") 'evil-ace-jump-char-mode)
(define-key evil-motion-state-map (kbd "gl") 'evil-ace-jump-line-mode)

;; Exit

(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "dj" 'evil-normal-state)
(key-chord-define evil-replace-state-map "dj" 'evil-normal-state)

;;; Textobjects

(define-key evil-inner-text-objects-map "B" 'evil-buffer)
(define-key evil-outer-text-objects-map "B" 'evil-buffer)

(evil-define-text-object evil-buffer (count &optional beg end type)
  "Select entire buffer"
  `(,(point-min) ,(point-max)))

;; (define-key evil-inner-text-objects-map "f" 'evil-forward-inner-block)
;; (define-key evil-outer-text-objects-map "f" 'evil-forward-outer-block)

;; (evil-define-text-object evil-forward-inner-block (count &optional beg end type)
;;   "Find block forward and select it."
;;   (save-excursion `(,(+ 1 (goto-char (- (search-forward "(" nil nil count) 1)))
;; 		    ,(- (forward-list 1) 1))))

;; (evil-define-text-object evil-forward-outer-block (count &optional beg end type)
;;   "Find block forward and select it."
;;   (save-excursion `(,(goto-char (- (search-forward "(" nil nil count) 1))
;; 		    ,(forward-list 1))))

;;;;;; Custom keybindings!

(global-set-key "\M-9" 'insert-parentheses)
(global-set-key "\M-8" "*")

(global-set-key (kbd "C-0") 'delete-window)
(global-set-key (kbd "C-1") 'delete-other-windows)
(global-set-key (kbd "C-2") 'split-window-below)
(global-set-key (kbd "C-3") 'split-window-right)
(global-set-key (kbd "C-4") ctl-x-4-map)
(global-set-key (kbd "C-5") ctl-x-5-map)
(global-set-key (kbd "C-6") '2C-command)
;(global-set-key (kbd "C-7") ) UNDEFINED
;(global-set-key C-x 8 is a complex translation map not loaded by default.
;(global-set-key (kbd "C-9") ) UNDEFINED

(global-set-key [C-tab] 'other-window)
(global-set-key [C-S-iso-lefttab] (lambda () (interactive) (other-window -1)))

(global-set-key [M-right] 'next-buffer)
(global-set-key [M-left] 'previous-buffer)

(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
This is the same as using \\[set-mark-command] with the prefix argument."
  (interactive)
  (set-mark-command 1))
(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark))
(global-set-key (kbd "M-`") 'jump-to-mark)
(global-set-key (kbd "C-'") 'push-mark-no-activate)

(defun kill-this-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-cross-lines t)
 '(evil-shift-width 2)
 '(idris-interpreter-path "~/.cabal/bin/idris")
 '(prolog-indent-width 2)
 '(prolog-system (quote swi))
 '(recenter-positions (quote (bottom middle top)))
 '(scheme-program-name "racket"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray10" :foreground "gray" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "xos4" :family "Terminus"))))
 '(idris-loaded-region-face ((t (:background "black"))))
 '(linum ((t (:inherit (shadow default) :foreground "dim gray"))))
 '(mode-line ((t (:background "grey75" :foreground "black"))))
 '(mode-line-highlight ((t nil)))
 '(mode-line-inactive ((t (:inherit mode-line :background "grey30" :foreground "grey80" :weight light))))
 '(powerline-active1 ((t (:inherit mode-line :background "gray10" :foreground "white"))))
 '(powerline-active2 ((t (:inherit mode-line :background "gray20" :foreground "white"))))
 '(powerline-active3 ((t (:inherit mode-line :background "gray30" :foreground "white"))))
 '(powerline-inactive1 ((t (:inherit mode-line-inactive :background "grey10" :foreground "dim gray"))))
 '(powerline-inactive2 ((t (:inherit mode-line-inactive :background "grey10" :foreground "dim gray"))))
 ;; '(region ((t (:background "black"))))
 '(shm-current-face ((t (:background "gray20"))) t)
 '(shm-quarantine-face ((t (:background "black"))) t)
 '(show-paren-match ((t (:background "gray20"))))
 '(vertical-border ((t (:foreground "gray10")))))

;; Sublime emulation

;(require 'sublimity)
;(require 'sublimity-map)

;(setq sublimity-map-size 20)
;(setq sublimity-map-fraction 0.3)
;(setq sublimity-map-text-scale -7)
;(sublimity-map-set-delay nil)

;(sublimity-mode)

;; Structured-Haskell-Mode

;(add-to-list 'load-path "~/Programming/Haskell/structured-haskell-mode/elisp")
;(setq shm-program-name "/home/ashley/.cabal/bin/structured-haskell-mode")
;(require 'shm)

;(add-hook 'haskell-mode-hook 'structured-haskell-mode)
