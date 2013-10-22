
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


;;; browse-url-dwim-coerce-to-web-url

(ert-deftest browse-url-dwim-coerce-to-web-url-01 nil
  (let ((value "http://www.example.com"))
    (should
     (equal
      value
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-02 nil
  (let ((value "http://www.example.com/long/path/to/document.html"))
    (should
     (equal
      value
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-03 nil
  (let ((value "www.example.com"))
    (should
     (equal
      (concat "http://" value)
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-04 nil
  (let ((value "example.com"))
    (should
     (equal
      (concat "http://" value)
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-05 nil
  (let ((value "www.example.com/long/path/to/document.html"))
    (should
     (equal
      (concat "http://" value)
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-06 nil
  (let ((value "example.com/long/path/to/document.html"))
    (should
     (equal
      (concat "http://" value)
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-07 nil
  (let ((value "www.example.co.uk"))
    (should-not
     (browse-url-dwim-coerce-to-web-url value))))

(ert-deftest browse-url-dwim-coerce-to-web-url-08 nil
  (let ((value "example.co.uk"))
    (should-not
     (browse-url-dwim-coerce-to-web-url value))))

(ert-deftest browse-url-dwim-coerce-to-web-url-09 nil
  (let ((value "www.example.co.uk/long/path/to/document.html"))
    (should-not
     (browse-url-dwim-coerce-to-web-url value))))

(ert-deftest browse-url-dwim-coerce-to-web-url-10 nil
  (let ((value "example.co.uk/long/path/to/document.html"))
    (should-not
     (browse-url-dwim-coerce-to-web-url value))))

(ert-deftest browse-url-dwim-coerce-to-web-url-11 nil
  (let ((value "www.example.co.uk")
        (browse-url-dwim-permitted-tlds browse-url-dwim-permitted-tlds))
    (push "uk" browse-url-dwim-permitted-tlds)
    (should
     (equal
      (concat "http://" value)
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-12 nil
  (let ((value "example.co.uk")
        (browse-url-dwim-permitted-tlds browse-url-dwim-permitted-tlds))
    (push "uk" browse-url-dwim-permitted-tlds)
    (should
     (equal
      (concat "http://" value)
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-13 nil
  (let ((value "www.example.co.uk/long/path/to/document.html")
        (browse-url-dwim-permitted-tlds browse-url-dwim-permitted-tlds))
    (push "uk" browse-url-dwim-permitted-tlds)
    (should
     (equal
      (concat "http://" value)
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-14 nil
  (let ((value "example.co.uk/long/path/to/document.html")
        (browse-url-dwim-permitted-tlds browse-url-dwim-permitted-tlds))
    (push "uk" browse-url-dwim-permitted-tlds)
    (should
     (equal
      (concat "http://" value)
      (browse-url-dwim-coerce-to-web-url value)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-15 nil
  (let ((value "www.example.com")
        (scheme "https://"))
    (should
     (equal
      (concat scheme value)
      (browse-url-dwim-coerce-to-web-url value nil scheme)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-16 nil
  (let ((value "http://www.example.com")
        (scheme "https://"))
    (should
     (equal
      value
      (browse-url-dwim-coerce-to-web-url value nil scheme)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-17 nil
  (let ((value "gopher://example.com"))
    (should-not
      (browse-url-dwim-coerce-to-web-url value))))

(ert-deftest browse-url-dwim-coerce-to-web-url-18 nil
  (let ((value "gopher://example.com"))
    (should
     (equal
      value
      (browse-url-dwim-coerce-to-web-url value 'any-scheme)))))

(ert-deftest browse-url-dwim-coerce-to-web-url-19 nil
  (let ((value "mailto:example@example.com"))
    (should-not
     (browse-url-dwim-coerce-to-web-url value))))

(ert-deftest browse-url-dwim-coerce-to-web-url-20 nil
  (let ((value "mailto:example@example.com"))
    (should
     (equal
      value
      (browse-url-dwim-coerce-to-web-url value 'any-scheme)))))


;;; browse-url-dwim-context-url

(ert-deftest browse-url-dwim-context-url-01 nil
  (should-not
   (with-temp-buffer
     (insert "meaningless text\n")
     (goto-char (point-min))
     (browse-url-dwim-context-url))))

(ert-deftest browse-url-dwim-context-url-02 nil
  (let ((value "http://www.example.com"))
    (should
     (equal
      value
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-03 nil
  (let ((value "http://www.example.com/long/path/to/document.html"))
    (should
     (equal
      value
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-04 nil
  (let ((value "www.example.com"))
    (should
     (equal
      (concat "http://" value)
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-05 nil
  (let ((value "www.example.com/long/path/to/document.html"))
    (should
     (equal
      (concat "http://" value)
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-06 nil
  "Currently a limitation of using thing-at-point-short-url-regexp: two dots required in host"
  :expected-result (if (<= emacs-major-version 23) :passed :failed)
  (let ((value "example.com"))
    (should
     (equal
      (concat "http://" value)
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-07 nil
  "Currently a limitation of using thing-at-point-short-url-regexp: two dots required in host"
  :expected-result (if (<= emacs-major-version 23) :passed :failed)
  (let ((value "example.com/long/path/to/document.html"))
    (should
     (equal
      (concat "http://" value)
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-08 nil
  (let ((value "example.co.uk"))
    (should-not
     (with-temp-buffer
       (insert value "\n")
       (goto-char (point-min))
       (browse-url-dwim-context-url)))))

(ert-deftest browse-url-dwim-context-url-09 nil
  (let ((value "http://example.co.uk"))
    (should
     (equal
      value
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-10 nil
  (let ((value "https://example.co.uk"))
    (should
     (equal
      value
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-11 nil
  (let ((value "gopher://example.co.uk/"))
    (should-not
     (with-temp-buffer
       (insert value "\n")
       (goto-char (point-min))
       (browse-url-dwim-context-url)))))

(ert-deftest browse-url-dwim-context-url-12 nil
  (let ((value "gopher://example.co.uk/")
        (browse-url-dwim-permitted-schemes browse-url-dwim-permitted-schemes))
    (push "gopher" browse-url-dwim-permitted-schemes)
    (should
     (equal
      value
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-13 nil
  (let ((value "mailto:example@example.com"))
    (should-not
     (equal
      value
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-14 nil
  (let ((value "mailto:example@example.com")
        (browse-url-dwim-permitted-schemes browse-url-dwim-permitted-schemes))
    (push "mailto" browse-url-dwim-permitted-schemes)
    (should
     (equal
      value
      (with-temp-buffer
        (insert value "\n")
        (goto-char (point-min))
        (browse-url-dwim-context-url))))))

(ert-deftest browse-url-dwim-context-url-15 nil
  (let ((value "http://www.example.com/long/path/to/document.html")
        (chars 28))
    (should
     (equal
      (substring value 0 chars)
      (with-temp-buffer
        (transient-mark-mode 1)
        (insert value "\n")
        (goto-char (1+ chars))
        (push-mark (point-min) t t)
        (browse-url-dwim-context-url))))))


;;; browse-url-dwim-make-search-prompt

(ert-deftest browse-url-dwim-make-search-prompt-01 nil
  (let ((value "http://www.google.com/search?ie=utf-8&oe=utf-8&q="))
    (should
     (equal
      "Google: "
      (browse-url-dwim-make-search-prompt value)))))

(ert-deftest browse-url-dwim-make-search-prompt-02 nil
  (let ((value "http://www.example.com"))
    (should
     (equal
      "Internet Search: "
      (browse-url-dwim-make-search-prompt value)))))


;;; browse-url-dwim-add-prompt-default

(ert-deftest browse-url-dwim-add-prompt-default-01 nil
  (let ((value "http://www.google.com/search?ie=utf-8&oe=utf-8&q=")
        (prompt "Prompt: ")
        (clean-prompt "Prompt"))
    (should
     (equal
      (format "%s (%s): " clean-prompt (substring value 0 40))
      (browse-url-dwim-add-prompt-default prompt value)))))

(ert-deftest browse-url-dwim-add-prompt-default-02 nil
  (let ((value "http://www.google.com/search?ie=utf-8&oe=utf-8&q=")
        (prompt "Prompt: ")
        (clean-prompt "Prompt"))
    (should
     (equal
      (format "%s (%s): " clean-prompt (substring value 0 10))
      (browse-url-dwim-add-prompt-default prompt value 10)))))


;;; todo - browse-url-dwim-find-search-text

(ert-deftest browse-url-dwim-find-target-text-01 nil
  :tags '(:interactive)
  (should
   (equal
    "meaningless"
   (with-temp-buffer
     (insert "meaningless text\n")
     (goto-char (point-min))
     (browse-url-dwim-find-search-text)))))


;;; todo - browse-url-dwim-get-url (&optional always-prompt prompt-string fallback-default)

(ert-deftest browse-url-dwim-get-url-01 nil
  :tags '(:interactive)
  (let ((value "http://www.example.com"))
  (should
   (equal
    value
   (with-temp-buffer
     (insert value "\n")
     (goto-char (point-min))
     (browse-url-get-url))))))

;;; todo - browse-url-dwim (url)

;;; todo - browse-url-dwim-search (&optional text search-url guess)

;;; todo - browse-url-dwim-guess (&optional text search-url)

;;; todo - browse-url-dwim-mode

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
