;; recentf is required by helm-recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 100)
;; ==== HELM ====
(require 'helm)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-r") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(require 'helm-config)
(setq helm-split-window-in-side-p t)
; (helm-display-source-at-screen-top nil)
; (helm-autoresize-mode t)
(setq helm-split-window-default-side 'below)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(setq helm-echo-input-in-header-line t)
(setq helm-buffers-truncate-lines nil)
(defun helm-hide-minibuffer-maybe ()
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face (let ((bg-color (face-background 'default nil)))
                              `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))
(add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)
(defun fu/helm-find-files-navigate-forward (orig-fun &rest args)
  (if (file-directory-p (helm-get-selection))
      (apply orig-fun args)
    (helm-maybe-exit-minibuffer)))
(advice-add 'helm-execute-persistent-action :around #'fu/helm-find-files-navigate-forward)
(defun fu/helm-find-files-navigate-back (orig-fun &rest args)
  (if (= (length helm-pattern) (length (helm-find-files-initial-input)))
      (helm-find-files-up-one-level 1)
    (apply orig-fun args)))
(advice-add 'helm-ff-delete-char-backward :around #'fu/helm-find-files-navigate-back)

(defun wu/helm-mini ()
  (interactive)
  (helm :sources helm-mini-default-sources
      :buffer "*helm mini*"
      :truncate-lines nil))
(helm-mode 1)
;; hooks need helm-find-files-map ready
(define-key helm-find-files-map (kbd "<return>") 'helm-execute-persistent-action)

(require 'helm-projectile)
(setq projectile-enable-caching t)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(with-eval-after-load 'helm-projectile
  (defvar helm-source-file-not-found
    (helm-build-dummy-source
        "Create file"
      :action (lambda (cand) (find-file cand))))
  (add-to-list 'helm-projectile-sources-list helm-source-file-not-found t))
(helm-projectile-on)
(setq projectile-keymap-prefix (kbd "C-c C-p"))

;; C-p to open helm-projectile
(global-set-key (kbd "C-c C-p") 'helm-projectile)
(define-key evil-normal-state-map (kbd "C-c C-p") 'helm-projectile)
;; Map ESC to close helm-projectile in GUI, seems not work in terminal ;(
; (defun my-helm-init ()
;   (define-key helm-map [escape] 'helm-keyboard-quit)
;   (define-key helm-map "\e" 'helm-keyboard-quit)
; )

; (add-hook 'after-init-hook 'my-helm-init)
