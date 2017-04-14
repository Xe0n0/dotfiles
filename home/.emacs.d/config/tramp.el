(require 'tramp)
(require 'cl)
;(setq tramp-verbose 10)
(setq tramp-default-method "/usr/local/bin/ssh")
(setq tramp-use-ssh-controlmaster-options nil)
      ;(concat
      ; "-o ControlPath='~/.ssh/sockets/emacs.%%r@%%h:%%p' "
      ; "-o ControlMaster=auto -o ControlPersist=yes "))
(defun tramp-get-method-parameter (method param)
  "Return the method parameter PARAM.
If the `tramp-methods' entry does not exist, return NIL."
  (let ((entry (assoc param (assoc method tramp-methods))))
    (when entry (cadr entry))))

(defun tramp-set-method-parameter (method param newvalue)
  "Set the method paramter PARAM to VALUE for METHOD.

If METHOD does not yet have PARAM, add it.
If METHOD does not exist, do nothing."
  (let ((method-params (assoc method tramp-methods)))
    (when method-params
          (let ((entry (assoc param method-params)))
        (if entry
            (setcar (cdr entry) newvalue)
          (setcdr (last method-params) '(param newvalue)))))))

(defun tramp-add-args (programs newargs)
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
(tramp-add-args
 '("scp" "scp1" "scp2" "scp1_old" "scp2_old" "sftp" "rsync" "ssh" "ssh1" "ssh2" "ssh1_old" "ssh2_old" "scpx" "sshx")
 '(("-o" "ControlPath=~/.ssh/sockets/shared-%%r@%%h:%%p" "-o" "ControlMaster=auto" "-o" "ControlPersist=12000" "-o" "Ciphers=arcfour" "-o" "Compression=yes" "-o" "StrictHostKeyChecking=no")))
