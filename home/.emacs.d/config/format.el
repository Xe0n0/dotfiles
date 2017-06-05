(add-hook 'sh-mode-hook (lambda ()
  (setq sh-basic-offset 2)
  (setq sh-indentation 2)))

(add-hook 'c++-mode-hook #'modern-c++-font-lock-mode)
