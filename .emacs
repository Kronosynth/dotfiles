;; start the emacs server, load (+ save) sessions

(server-start)
(package-initialize)
(desktop-save-mode)

;; no menu-bar, toolbar or scroll bar

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; clean *scratch*, no more startup screen

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; window dimensions

;(add-to-list 'default-frame-alist '(width . 155))
;(add-to-list 'default-frame-alist '(height . 43))

;; Split windows horizontally by default

;(setq split-height-threshold 80)
;(setq split-width-threshold 160)

;; color theme and transparency... and remove vertical borders

(add-to-list 'default-frame-alist '(foreground-color . "gray"))
(add-to-list 'default-frame-alist '(background-color . "gray10"))
(add-to-list 'default-frame-alist '(cursor-color . "white"))
;(add-to-list 'default-frame-alist '(alpha . (95 90))) ;; Centralized transparency rules in my xmonad.hs
(set-face-foreground 'vertical-border "gray10")
;(set-face-background 'vertical-border "gray10")

;; Window title for topbar.

(setq frame-title-format '("xi: " (buffer-file-name "%f" (dired-directory dired-directory "%b"))))
;; (setq frame-title-format "xi")



;; truncate lines and make column numbers visible

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

;; delete-selection-mode

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

;; Add line numbers to programming buffers, highlight indentation and
;; colorize their colour codes.

(require 'indent-guide)

(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'prog-mode-hook 'indent-guide-mode)
(add-hook 'prog-mode-hook 'rainbow-mode)

(eval-after-load 'rainbow-mode '(diminish 'rainbow-mode))
(eval-after-load 'indent-guide '(diminish 'indent-guide-mode))

;; Undo-tree mode, make it global, diminish it from modelines.

(global-undo-tree-mode)
(diminish 'undo-tree-mode)
;eval-after-load "undo-tree" '(global-undo-tree-mode))
;eval-after-load "diminish" '(diminish 'undo-tree-mode))

;; Ido mode and all associated paraphernalia

(ido-mode)

(add-hook 'ido-setup-hook 'ido-my-keys)

(defun ido-my-keys ()
  (define-key ido-completion-map (kbd "TAB") 'ido-next-match))

(ido-ubiquitous-mode)
(ido-vertical-mode)
(ido-at-point-mode)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'execute-extended-command)

(setq smex-prompt-string ">>= ")
;(setq smex-auto-update nil)
;(smex-auto-update 60)

;; Configure package archives

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")))

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
;(setq shm-program-name "/home/kron/.cabal/bin/structured-haskell-mode")
;(require 'shm)

;(add-hook 'haskell-mode-hook 'structured-haskell-mode)



;; Registers!

(set-register ?e '(file . "~/.emacs"))
(set-register ?g '(file . "~/.ghci"))
(set-register ?m '(file . "~/.xmonad/xmonad.hs"))
(set-register ?b '(file . "~/.bashrc"))
(set-register ?c '(file . "~/.xmonad/.conky_dzen"))
(set-register ?v '(file . "~/.vimperatorrc"))
(set-register ?z '(file . "~/.zshrc"))
(set-register ?i '(file . "~/.xinitrc"))
(set-register ?d '(file . "~/.Xdefaults"))

(set-register ?t '(file . "~/todo.navi"))

;; Set auto-mode-alist for various modes and autload others

(setq auto-mode-alist (append '(("\\.vimperatorrc\\'" . vimrc-mode)
				("\\.h\\'" . c++-mode)
				("\\.rkt\\'" . scheme-mode)
				("\\.pl\\'" . prolog-mode))
			      auto-mode-alist))

;; Evil mode and powerline to go with it

(evil-mode)

(add-to-list 'load-path "~/.emacs.d/powerline/")
(require 'powerline)
(powerline-evil-theme)

(define-key evil-normal-state-map (kbd "C-j") 'evil-scroll-page-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-scroll-page-up)
(define-key evil-normal-state-map (kbd "C-e") 'evil-end-of-line)

(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)

;; Custom keybindings!

(global-set-key "\M-9" 'insert-parentheses)
(global-set-key "\M-8" (lambda () (interactive) (insert "*")))

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
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))
(global-set-key (kbd "M-`") 'jump-to-mark)
(global-set-key (kbd "C-'") 'push-mark-no-activate)

(defun kill-this-buffer () 
  (interactive) 
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)

;; ;; Load VIP and move some keys around for vim-like movement

;; (load "vip")
;; (global-set-key "\C-z" 'vip-change-mode-to-vi)

;; ; (backward-char) C-b <- C-h is the help map (help-command)
;; ; (next-line) C-n     <- C-j is (newline-and-indent)
;; ; (previous-line) C-p <- C-k is (kill-line)
;; ; (forward-char) C-f  <- C-l is (recenter-top-bottom)

;; (global-set-key "\C-b" 'help-command)
;; (global-set-key "\C-n" 'newline-and-indent)
;; (global-set-key "\C-p" 'kill-line)
;; (global-set-key "\C-f" 'recenter-top-bottom)

;; (global-set-key "\C-h" 'backward-char)
;; (global-set-key "\C-j" 'next-line)
;; (global-set-key "\C-k" 'previous-line)
;; (global-set-key "\C-l" 'forward-char)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-cross-lines t)
 '(evil-move-cursor-back nil)
 '(haskell-mode-hook (quote (turn-on-haskell-simple-indent)))
 '(prolog-indent-width 2)
 '(prolog-system (quote swi))
 '(recenter-positions (quote (bottom middle top)))
 '(scheme-program-name "racket"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:inherit (shadow default) :foreground "dim gray"))))
 '(mode-line ((t (:background "grey75" :foreground "black"))))
 '(mode-line-highlight ((t nil)))
 '(mode-line-inactive ((t (:inherit mode-line :background "grey30" :foreground "grey80" :weight light))))
 '(powerline-active1 ((t (:inherit mode-line :background "gray10" :foreground "white"))))
 '(powerline-active2 ((t (:inherit mode-line :background "gray20" :foreground "white"))))
 '(powerline-active3 ((t (:inherit mode-line :background "gray30" :foreground "white"))))
 '(powerline-inactive1 ((t (:inherit mode-line-inactive :background "grey10" :foreground "dim gray"))))
 '(powerline-inactive2 ((t (:inherit mode-line-inactive :background "grey10" :foreground "dim gray"))))
 '(shm-current-face ((t (:background "gray20"))))
 '(shm-quarantine-face ((t (:background "black"))))
 '(show-paren-match ((t (:background "gray20")))))
