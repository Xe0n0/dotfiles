(load-theme 'base16-eighties-dark t)

; ==== GUI Configuration ====
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(font . "Menlo-14") '(height . 140))
(add-to-list 'initial-frame-alist '(font . "Menlo-14") '(height . 140))

(set-default-font "Menlo-14")


(put 'erase-buffer 'disabled nil)

; ==== Chinese Configuration ====
(set-fontset-font t 'han '("PingFang SC"))

