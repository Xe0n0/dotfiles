(setq scheme-program-name 'racket)
(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))
(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

(add-hook 'scheme-mode-hook 'geiser-mode)
(setq geiser-active-implementations '(racket))


(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")


("quicklisp-slime-helper")
