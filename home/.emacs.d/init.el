(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(js2-basic-offset 2 t)
 '(js2-bounce-indent-p t t)
 '(mac-option-modifier (quote (:ordinary meta :function alt :mouse alt)))
 '(tool-bar-mode nil))
(add-to-list 'default-frame-alist '(font . "Menlo") '(height . 140))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq vc-follow-symlinks t)
(defun load-directory (directory)
  "Load recursively all `.el' files in DIRECTORY."
  (dolist (element (directory-files-and-attributes directory nil nil nil))
    (let* ((path (car element))
           (fullpath (concat directory "/" path))
           (isdir (eq (car (cdr element)) t))
           (ignore-dir (or (string= path ".") (string= path ".."))))
      (cond
       ((and (eq isdir t) (not ignore-dir))
        (load-directory fullpath))
       ((and (eq isdir nil) (string= (substring path -3) ".el"))
        (load (file-name-sans-extension fullpath)))))))

(let (
        (mypaths
         '(
           "/usr/local/bin"
           "/usr/local/sbin"
           "/bin"
           "/usr/bin"
           "/Users/wuhaotian/homebrew/bin"
           ) )
        )

    (setenv "PATH" (mapconcat 'identity mypaths ":") )

    (setq exec-path (append mypaths (list "." exec-directory)) )
    )

(let ((benchmark-init.el "~/.emacs.d/elpa/benchmark-init-20141004.609/benchmark-init.el"))
  (when (file-exists-p benchmark-init.el)
    (load benchmark-init.el)))
;; (benchmark-init/activate)

;; ==== Emacs System Setup ====
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; ==== COMMON SETUP ====
(setq css-indent-offset 2)
(setq tab-width 2)
(setq-default indent-tabs-mode nil)

;; ==== PACKAGE SETUP ====
(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
      package-archives)
(push '("melpa" . "http://melpa.milkbox.net/packages/")
      package-archives)
(push '("melpa" . "http://melpa.org/packages/")
      package-archives)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(setq package-list
      '(xterm-color
        auto-complete
        ac-js2
        base16-theme
        benchmark-init
        emmet-mode
        evil
        evil-leader
        evil-mc
        smartparens
        multiple-cursors
        fasd
        geiser ;; Scheme REPL
        helm
        helm-projectile
        js2-mode
        ac-js2
        magit
        markdown-mode
        powerline
        powerline-evil
        projectile
        racket-mode
        rainbow-delimiters
        skewer-mode
        slime
        smart-mode-line
        web-mode
        xterm-color
        multi-term))
(mapc #'package-install package-list)

(load-directory "~/.emacs.d/config")

;; ==== Utils ====
(if (fboundp 'with-eval-after-load)
    (defmacro after (feature &rest body)
      "After FEATURE is loaded, evaluate BODY."
      (declare (indent defun))
      `(with-eval-after-load ,feature ,@body))
  (defmacro after (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
    `(eval-after-load ,feature
       '(progn ,@body))))

;; ==== Modes ====
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ng\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-ac-sources-alist
  '(("css" . (ac-source-css-property))
    ("html" . (ac-source-words-in-buffer ac-source-abbrev))
    ("ng" . (ac-source-words-in-buffer ac-source-abbrev))))
(add-hook
 'web-mode-hook
 '(lambda ()
    (local-set-key (kbd "C-c C-h") 'windmove-left)))
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
;; ==== FORMATING ====
;(require 'dtrt-indent)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
; (add-hook 'prog-mode-hook #'dtrt-indent-mode)
(setq sgml-basic-offset 2)
(setq evil-shift-width 2)
(define-key global-map (kbd "RET") 'newline-and-indent)

;; ==== Magic ====
(defun add-skewer-key (mode)
  (cond ((string= mode "css")
         (global-set-key (kbd "C-c C-r") 'skewer-css-eval-current-))
        ((string= mode "js2")
         (global-set-key (kbd "C-c C-r") 'skewer-eval-defun))
        ((string= mode "html")
         (global-set-key (kbd "C-c C-r") 'skewer-html-eval-tag))
  ))
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'js2-mode-hook (apply-partially #'add-skewer-key "js2"))
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'css-mode-hook (apply-partially #'add-skewer-key "css"))
(add-hook 'html-mode-hook 'skewer-mode)
(add-hook 'html-mode-hook (apply-partially #'skewer-html-mode "html"))


;; ==== AUTO COMPLETE ===
(ac-config-default)

;; ==== Multiple Cursors ====
(require 'multiple-cursors)
(global-set-key (kbd "C-S-l") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-D") 'mc/mark-sgml-tag-pair)
(after 'evil
  (add-hook 'multiple-cursors-mode-enabled-hook 'evil-emacs-state)
  (add-hook 'multiple-cursors-mode-disabled-hook 'evil-normal-state))

(require 'evil-mc)
(global-evil-mc-mode 1)

;; ==== MAGIT ====
(require 'magit)

;; -- powerline --
; (require 'powerline)
; (powerline-default-theme)
; (setq airline-helm-colors ''f)
; (require 'airline-themes)
; (load-theme 'airline-base16-gui-dark)
; (require 'powerline-evil)
;(powerline-evil-vim-theme)
;; These two lines are just examples
; (setq powerline-arrow-shape 'curve)
; (setq powerline-default-separator-dir '(right . left))
;; These two lines you really need.
; (setq sml/theme 'respectful)
(sml/setup)
; (display-time-mode t)

; ; redefine emacs state to intercept the escape key like insert-state does:
; (evil-define-state emacs
;   "Emacs state that can be exited with the escape key."
;   :tag " <EE> "
;   :message "-- EMACS WITH ESCAPE --"
;   :input-method t
;   ;; :intercept-esc nil)
;   )

; (defadvice evil-insert-state (around emacs-state-instead-of-insert-state activate)
;   (evil-emacs-state))
 ;; Set your lisp system and, optionally, some contribs
(setq inferior-lisp-program "/usr/local/bin/clisp")
(setq slime-contribs '(slime-fancy))
;; ==== FASD ====
(global-fasd-mode 1)
(setq fasd-enable-initial-prompt nil)
(setq fasd-completing-read-function 'helm-comp-read)

;; ==== SMARTPARENS ====
(require 'smartparens-config)
(add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)

;; customize functions
(defun restart ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

; (setq inhibit-splash-screen t)
; (switch-to-buffer "**")
(put 'set-goal-column 'disabled nil)
