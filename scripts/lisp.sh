curl -o /tmp/quicklisp.lisp https://beta.quicklisp.org/quicklisp.lisp
curl -o /tmp/quicklisp.asc https://beta.quicklisp.org/quicklisp.lisp.asc
gpg --import ./res/quicklisp.key
pushd /tmp
gpg --verify quicklisp.asc quicklisp.lisp &&
sbcl --load quicklisp.lisp
popd
