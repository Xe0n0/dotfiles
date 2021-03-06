;; ==== JavaScript ====
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.gss\\'" . css-mode))
(add-hook 'css-mode-hook '(lambda ()
                             (setq require-final-newline t)
                             (setq mode-require-final-newline t)))
(custom-set-variables
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
)
(setq js2-highlight-level 3)
(setq js-indent-level 2)
(setq js2-basic-offset 2)  
(setq js2-bounce-indent-p t) 
(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-hook 'js2-mode-hook 'column-enforce-mode)
