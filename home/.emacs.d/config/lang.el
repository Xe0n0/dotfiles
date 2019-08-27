(require 'slime)
(add-hook 'after-init-hook 'global-company-mode)

(setq scheme-program-name 'racket)
(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))
(add-hook 'racket-mode-hook
          (lambda ()
            (set-face-attribute 'racket-selfeval-face nil
                    :inherit font-lock-constant-face
                    :foreground nil)

            (set-face-attribute 'racket-keyword-argument-face
                    :inherit font-lock-keyword-face
                    :foreground nil)

            (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

(add-hook 'scheme-mode-hook 'geiser-mode)
(setq geiser-active-implementations '(racket))


;;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")


;;("quicklisp-slime-helper")

(setq-default c-basic-offset 2
            indent-tabs-mode nil)

(setq c-default-style "linux"
      c-basic-offset 2)

;; fix Java mode offset
(add-hook 'java-mode-hook (lambda ()
                            (c-set-offset 'inexpr-class 0)
                            (setq c-basic-offset 2
                                  tab-width 2
                                  indent-tabs-mode nil)))

;; Set google c/c++ style
(add-hook 'c-mode-common-hook 'google-set-c-style)
