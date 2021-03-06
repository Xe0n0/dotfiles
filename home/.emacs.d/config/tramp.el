(require 'tramp)
(require 'cl)
(setq projectile-mode-line "Projectile")
(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp
      (format "%s\\|%s"
                    vc-ignore-dir-regexp
                    tramp-file-name-regexp))
;; (setq tramp-verbose 1)


(setq tramp-default-method "ssh")
(setq tramp-use-ssh-controlmaster-options nil)
(setq tramp-inline-compress-start-size 1)
(setq tramp-copy-size-limit 1000000)
(add-to-list 'backup-directory-alist
    (cons tramp-file-name-regexp nil))
;; (setq tramp-ssh-controlmaster-options
;;        (concat
;;         "-o ControlPath='~/.ssh/sockets/shared-%%r@%%h:%%p' "
;;         "-o ControlMaster=auto -o ControlPersist=yes "))

(defun wu/tramp-get-method-parameter (method param)
  "Return the method parameter PARAM.
If the `tramp-methods' entry does not exist, return NIL."
  (let ((entry (assoc param (assoc method tramp-methods))))
    (when entry (cadr entry))))

(defun wu/tramp-set-method-parameter (method param newvalue)
  "Set the method paramter PARAM to VALUE for METHOD.

If METHOD does not yet have PARAM, add it.
If METHOD does not exist, do nothing."
  (let ((method-params (assoc method tramp-methods)))
    (when method-params
          (let ((entry (assoc param method-params)))
        (if entry
            (setcar (cdr entry) newvalue)
          (setcdr (last method-params) '(param newvalue)))))))

(defun wu/tramp-add-args (programs newargs)
  "Append NEWARGS to the argument list for any of PROGRAMS in `tramp-methods'.

PROGRAMS can be a list of strings, or a single string."
  ;; Allow a single program string or a list of matching programs.
  (when (stringp programs)
    (setq programs (list programs)))
  (message "%s" (list programs newargs))
  (loop for method in (mapcar 'car tramp-methods) do
        (let ((login-program (tramp-get-method-parameter method 'tramp-login-program))
              (copy-program (tramp-get-method-parameter method 'tramp-copy-program))
              (login-args (tramp-get-method-parameter method 'tramp-login-args))
              (copy-args (tramp-get-method-parameter method 'tramp-copy-args)))
          (message "Handling %s" method)
          (message "  Handling login program %s" login-program)
          (when (find login-program programs :test 'string=)
            (message "    Adding to login program %s" login-program)
            (tramp-set-method-parameter method 'tramp-login-args (append login-args newargs)))
          (message "  Handling copy program %s" login-program)
          (when (find copy-program programs :test 'string=)
            (message "    Adding to copy program %s" copy-program)
            (tramp-set-method-parameter method 'tramp-copy-args (append copy-args newargs))))))
;; (tramp-add-args
;;  '("scp" "scp1" "scp2" "scp1_old" "scp2_old" "sftp" "rsync" "ssh" "ssh1" "ssh2" "ssh1_old" "ssh2_old" "scpx" "sshx")
;;  '(("-o" "ControlPath=~/.ssh/sockets/shared-%%r@%%h:%%p" "-o" "ControlMaster=auto" "-o" "Cipher=aes128-gcm@openssh.com" "-o" "ControlPersist=12000" "-o" "Compression=yes" "-o" "StrictHostKeyChecking=no")))
