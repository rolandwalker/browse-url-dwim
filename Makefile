EMACS=emacs
# EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs
# EMACS=/Applications/Emacs23.app/Contents/MacOS/Emacs
# EMACS=/Applications/Aquamacs.app/Contents/MacOS/Aquamacs
# EMACS=/Applications/Macmacs.app/Contents/MacOS/Emacs
# EMACS=/usr/local/bin/emacs
# EMACS=/opt/local/bin/emacs
# EMACS=/usr/bin/emacs
EMACS_CLEAN=-Q
EMACS_BATCH=$(EMACS_CLEAN) --batch
TESTS=

CURL=curl --silent
EDITOR=runemacs -no_wait
WORK_DIR=$(shell pwd)
PACKAGE_NAME=$(shell basename $(WORK_DIR))
AUTOLOADS_FILE=$(PACKAGE_NAME)-loaddefs.el
TEST_DIR=ert-tests
TEST_DEP_1=ert
TEST_DEP_1_URL=http://bzr.savannah.gnu.org/lh/emacs/emacs-24/download/head:/ert.el-20110112160650-056hnl9qhpjvjicy-2/ert.el
TEST_DEP_2=string-utils
TEST_DEP_2_URL=https://raw.github.com/rolandwalker/string-utils/cefb98ecf8257f69d8288929fc0425f145484452/string-utils.el

build :
	$(EMACS) $(EMACS_BATCH) --eval             \
	    "(progn                                \
	      (setq byte-compile-error-on-warn t)  \
	      (batch-byte-compile))" *.el

test-dep-1 :
	@cd $(TEST_DIR)                                      && \
	$(EMACS) $(EMACS_BATCH)  -L . -L .. -l $(TEST_DEP_1) || \
	(echo "Can't load test dependency $(TEST_DEP_1).el, run 'make downloads' to fetch it" ; exit 1)

test-dep-2 :
	@cd $(TEST_DIR)                                   && \
	$(EMACS) $(EMACS_BATCH)  -L . -L .. --eval           \
	    "(progn                                          \
	      (setq package-load-list '(($(TEST_DEP_2) t)))  \
	      (when (fboundp 'package-initialize)            \
	       (package-initialize))                         \
	      (require '$(TEST_DEP_2)))"                  || \
	(echo "Can't load test dependency $(TEST_DEP_2).el, run 'make downloads' to fetch it" ; exit 1)

downloads :
	$(CURL) '$(TEST_DEP_1_URL)' > $(TEST_DIR)/$(TEST_DEP_1).el
	$(CURL) '$(TEST_DEP_2_URL)' > $(TEST_DIR)/$(TEST_DEP_2).el

autoloads :
	$(EMACS) $(EMACS_BATCH) --eval                       \
	    "(progn                                          \
	      (setq generated-autoload-file \"$(WORK_DIR)/$(AUTOLOADS_FILE)\") \
	      (update-directory-autoloads \"$(WORK_DIR)\"))"

test-autoloads : autoloads
	@$(EMACS) $(EMACS_BATCH) -l "./$(AUTOLOADS_FILE)" || echo "failed to load autoloads: $(AUTOLOADS_FILE)"

test : build test-dep-1 test-dep-2 test-autoloads
	@cd $(TEST_DIR)                                   && \
	(for test_lib in *-test.el; do                       \
	    $(EMACS) $(EMACS_BATCH) -L . -L .. -l cl -l $(TEST_DEP_1) -l $$test_lib --eval \
	    "(flet ((ert--print-backtrace (&rest args)       \
	      (insert \"no backtrace in batch mode\")))      \
	       (ert-run-tests-batch-and-exit '(and \"$(TESTS)\" (not (tag :interactive)))))" || exit 1; \
	done)

clean :
	@rm -f $(AUTOLOADS_FILE) *.elc *~ */*.elc */*~ $(TEST_DIR)/$(TEST_DEP_1).el $(TEST_DIR)/$(TEST_DEP_2).el

edit :
	@$(EDITOR) `git ls-files`