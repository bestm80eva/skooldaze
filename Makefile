BUILD = build
ASM_OPTIONS = $(ASM_OPTS)
HTML_OPTIONS = $(HTML_OPTS)
HTML_OPTIONS += -d $(BUILD)/html -t
NOSETESTS27 = /usr/bin/python2.7 /usr/bin/nosetests
NOSETESTS32 = $(HOME)/Python/Python3.2/bin/nosetests
NOSETESTS33 = $(HOME)/Python/Python3.3/bin/nosetests
NOSETESTS34 = /usr/bin/python3.4 /usr/bin/nosetests

HTML_OPTIONS += $(foreach theme,$(THEMES),-T $(theme))

.PHONY: usage
usage:
	@echo "Supported targets:"
	@echo "  usage    show this help"
	@echo "  sd       build the Skool Daze HTML disassembly"
	@echo "  sd.asm   build the Skool Daze ASM disassembly"
	@echo "  test     run tests with current Python interpreter"
	@echo "  test2.7  run tests with Python 2.7"
	@echo "  test3.2  run tests with Python 3.2"
	@echo "  test3.3  run tests with Python 3.3"
	@echo "  test3.4  run tests with Python 3.4"
	@echo ""
	@echo "Environment variables:"
	@echo "  SKOOLKIT_HOME  directory containing the version of SkoolKit to use"
	@echo "  BUILD          directory in which to build the disassembly (default: build)"
	@echo "  THEMES         CSS theme(s) to use"
	@echo "  HTML_OPTS      extra options passed to skool2html.py"
	@echo "  ASM_OPTS       options passed to skool2asm.py"

.PHONY: sd
sd:
	utils/sd2html.py $(HTML_OPTIONS)

.PHONY: sd.asm
sd.asm:
	mkdir -p $(BUILD)/asm
	utils/sd2asm.py $(ASM_OPTIONS) > $(BUILD)/asm/sd.asm

.PHONY: write-tests
write-tests:
	for t in asm ctl html sft; do utils/write-tests.py $$t > tests/test_$$t.py; done

.PHONY: test
test: write-tests
	nosetests -w tests

.PHONY: test2.7
test2.7: write-tests
	$(NOSETESTS27) -w tests

.PHONY: test3.2
test3.2: write-tests
	$(NOSETESTS32) -w tests

.PHONY: test3.3
test3.3: write-tests
	$(NOSETESTS33) -w tests

.PHONY: test3.4
test3.4: write-tests
	$(NOSETESTS34) -w tests
