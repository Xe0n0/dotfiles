(load-theme 'base16-eighties t)

; ==== GUI Configuration ====
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(font . "Menlo-13") '(height . 140))
(add-to-list 'initial-frame-alist '(font . "Menlo-13") '(height . 140))

(set-default-font "Menlo-14")


(put 'erase-buffer 'disabled nil)

; ==== Chinese Configuration ====
(set-fontset-font t 'han '("PingFang SC"))

;;; Based on http://arnab-deka.com/posts/2012/09/emacs-change-fonts-dynamically-based-on-screen-resolution/
(defun fontify-frame (&optional frame)
  (interactive)
  (let ((target (or frame (window-frame))))
    (if window-system
        (if (or
             (> (frame-pixel-height) 2000)
             (> (frame-pixel-width) 2000))
            (set-frame-parameter target 'font "Menlo 15")
          (set-frame-parameter target 'font "Menlo 14")))))
;;; Fontify current frame (so that it happens on startup; may be unnecessary if you use focus-in-hook)
(fontify-frame)
;;; Only in Emacs 24.4 (currently available as a pretest)
; see http://emacsredux.com/blog/2014/03/22/a-peek-at-emacs-24-dot-4-focus-hooks/
;; (add-hook 'focus-in-hook fontify-frame)
;;; For older Emacs versions - instead of changing on focus, this will change when a frame is created
;(push 'fontify-frame after-make-frame-functions)
