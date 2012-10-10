
;; requires and setup

(when load-file-name
  (setq package-enable-at-startup nil)
  (setq package-load-list '((list-utils t)
                            (string-utils t)))
  (when (fboundp 'package-initialize)
    (package-initialize)))

(require 'list-utils)
(require 'string-utils)
(require 'browse-url-dwim)

;;; this is a stub - no tests defined

;;; browse-url-dwim-coerce-to-web-url (url &optional any-scheme add-scheme)

;;; browse-url-dwim-add-prompt-default (prompt-string default-string &optional length-limit)

;;; browse-url-dwim-context-url ()

;;; browse-url-dwim-get-url (&optional always-prompt prompt-string fallback-default)

;;; browse-url-dwim-make-search-prompt (search-url)

;;; browse-url-dwim (url)

;;; browse-url-dwim-search (&optional text search-url guess)

;;; browse-url-dwim-guess (&optional text search-url)


;;
;; Emacs
;;
;; Local Variables:
;; indent-tabs-mode: nil
;; mangle-whitespace: t
;; require-final-newline: t
;; coding: utf-8
;; byte-compile-warnings: (not cl-functions)
;; End:
;;

;;; browse-url-dwim-test.el ends here
