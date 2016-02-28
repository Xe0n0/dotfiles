(require 'xterm-color)
(require 'multi-term)
(setq system-uses-terminfo nil)
;; ansi-color.el translates ANSI SGR (Select Graphic Rendition)
;;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; comint install xterm-color
;;(progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
;;      (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))
;;      (setq font-lock-unfontify-region-function 'xterm-color-unfontify-region))

;; comint uninstall
;(progn (remove-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
;       (add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
;       (setq font-lock-unfontify-region-function 'font-lock-default-unfontify-region))
(setq multi-term-program "zsh")
;; (defun my-term-use-utf8 ()
;;   (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
;; (add-hook 'term-exec-hook 'my-term-use-utf8)

;; (setq locale-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)
;; (custom-set-variables
;;  '(term-unbind-key-list
;;   '("C-p" "C-n" "C-z" "C-x" "C-c" "C-h" "C-y" "<ESC>"))
;;  '(term-bind-key-alist
;;   '(
;;     ("C-c C-c" . term-interrupt-subjob)
;;     ("C-s" . isearch-forward)
;;     ("C-r" . isearch-backward)
;;     ("C-m" . term-send-raw)
;;     ("M-f" . term-send-forward-word)
;;     ("M-b" . term-send-backward-word)
;;     ("M-o" . term-send-backspace)
;;     ("M-p" . term-send-up)
;;     ("M-n" . term-send-down)
;;     ("M-M" . term-send-forward-kill-word)
;;     ("M-N" . term-send-backward-kill-word)
;;     ("M-r" . term-send-reverse-search-history)
;;     ("M-," . term-send-input)
;;     ("M-." . comint-dynamic-complete))
;;   ))

(add-hook 'comint-mode-hook
          (lambda () (define-key comint-mode-map "\t" 'self-insert-command)))

(add-hook 'term-mode-hook
  (lambda ()
    (add-to-list 'term-unbind-key-list "C-p")
    (add-to-list 'term-unbind-key-list "C-n")
    (delete "C-p" term-unbind-key-list)
    (delete "C-n" term-unbind-key-list)))
