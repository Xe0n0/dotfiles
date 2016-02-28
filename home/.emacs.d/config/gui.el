(load-theme 'base16-eighties-dark t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "fbcdb6b7890d0ec1708fa21ab08eb0cc16a8b7611bb6517b722eba3891dfc9dd" "8e7ca85479dab486e15e0119f2948ba7ffcaa0ef161b3facb8103fb06f93b428" "e87a2bd5abc8448f8676365692e908b709b93f2d3869c42a4371223aab7d9cf8" "3539b3cc5cbba41609117830a79f71309a89782f23c740d4a5b569935f9b7726" "6ebb2401451dc6d01cd761eef8fe24812a57793c5ccc427b600893fa1d767b1d" "cda6cb17953b3780294fa6688b3fe0d3d12c1ef019456333e3d5af01d4d6c054" default)))
 ; '(display-time-mode t)
 ; '(initial-frame-alist (quote ((width . 120) (height . 60))))
 ; '(mac-drawing-use-gcd t)
 ; '(mac-mouse-wheel-mode t)
 ; '(mac-mouse-wheel-smooth-scroll t)
 '(mac-option-modifier (quote (:ordinary meta :function alt :mouse alt)))
 ; '(menu-bar-mode nil)
 ; '(scroll-all-mode nil)
 ; '(scroll-bar-mode nil)
 ; '(size-indication-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Meslo LG M for Powerline" :foundry "nil" :slant normal :weight normal :height 130 :width normal)))))

; ==== GUI Configuration ====
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(put 'erase-buffer 'disabled nil)

; ==== Chinese Configuration ====
(set-fontset-font t 'han '("PingFang SC"))
