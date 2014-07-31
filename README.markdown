[![Build Status](https://secure.travis-ci.org/rolandwalker/browse-url-dwim.png?branch=master)](http://travis-ci.org/rolandwalker/browse-url-dwim)

# Overview

Context-sensitive external browse URL or Internet search from Emacs.

 * [Quickstart](#quickstart)
 * [Explanation](#explanation)
 * [Outside the USA](#outside-the-usa)
 * [Notes](#notes)
 * [Compatibility and Requirements](#compatibility-and-requirements)

## Quickstart

```elisp
(require 'browse-url-dwim)
 
(browse-url-dwim-mode 1)
 
;; place the cursor on a URL
;; press "C-c b"
 
;; select some text
;; press "C-c g"
 
;; to turn off confirmations
(setq browse-url-dwim-always-confirm-extraction nil)
```

## Explanation

This small library for calling external browsers combines some of
the functionality of `browse-url` and `thingatpt`.

Three interactive commands are provided:

	browse-url-dwim
	browse-url-dwim-search
	browse-url-dwim-guess

each of which tries to extract URLs or meaningful terms from
context in the current buffer, and prompts for input when unable
to do so.

The context-sensitive matching of `browse-url-dwim` tries to do
*less* overall than the default behavior of `thingatpt`, on the
theory that `thingatpt` matches too liberally.  However,
`browse-url-dwim` does recognize some URLs that the default
`browse-url` ignores, such as "www.yahoo.com" without the
leading "http://".

To use `browse-url-dwim`, add the following to your `~/.emacs` file

```elisp
(require 'browse-url-dwim)      ; load library
(browse-url-dwim-mode 1)        ; install aliases and keybindings
```

Then place the cursor on a URL and press

<kbd>C-c</kbd> <kbd>b</kbd>  *(mnemonic: b for browse)*

or select some text and press

<kbd>C-c</kbd> <kbd>g</kbd>  *(mnemonic: g for Google)*

or (equivalently)

<kbd>M-x</kbd> <kbd>browse</kbd> <kbd>RET</kbd>
<kbd>M-x</kbd> <kbd>google</kbd> <kbd>RET</kbd>

## Outside the USA

If you are outside the USA, you will want to customize
`browse-url-dwim-permitted-tlds` so that your favorite
top-level domains will be recognized in context.  You
may also wish to customize `browse-url-dwim-search-url`
to point at an appropriate search engine.

## Notes

To control which browser is invoked, see the underlying library
`browse-url`.

By default, the minor mode binds and aliases `browse-url-dwim-guess`,
for Internet search, but the user might prefer to bind
`browse-url-dwim-search`, which has less DWIM:

```elisp
(define-key browse-url-dwim-map (kbd "C-c g") 'browse-url-dwim-search)
```

## Compatibility and Requirements

	GNU Emacs version 24.4-devel     : yes, at the time of writing
	GNU Emacs version 24.3           : yes
	GNU Emacs version 23.3           : yes
	GNU Emacs version 22.2           : yes, with some limitations
	GNU Emacs version 21.x and lower : unknown

Uses if present: [string-utils.el](http://github.com/rolandwalker/string-utils)
