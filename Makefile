install:
	ln -s `pwd`/count-todo /usr/local/bin/count-todo

uninstall:
	rm /usr/local/bin/count-todo

tests: test-basic test-list test-extras test-all
	@echo
	@echo "Success! All tests passed."
	@echo

test-basic:
	@ mkdir -p test-output
	@ rm -rf test-output/basic.txt
	@ ./count-todo > test-output/basic.txt
	@ grep -q "12" test-output/basic.txt || (echo "'test-basic' failed: Could not find '12'" && exit 1)
	@ echo "'test-basic' passed"

test-list:
	@ mkdir -p test-output
	@ rm -rf test-output/list.txt
	@ ./count-todo -l -d ./test > test-output/list.txt
	@ grep -q "9" test-output/list.txt || (echo "'test-list' failed: Could not find '9'" && exit 1)
	@ grep -q "Optimise my code" test-output/list.txt || (echo "'test-list' failed: Cound not find 'Optimise my code'" && exit 1)
	@ grep -q "example.ts" test-output/list.txt || (echo "'test-list' failed: Could not find '^example.ts'" && exit 1)
	@ echo "'test-list' passed"

test-extras:
	@ mkdir -p test-output
	@ rm -rf test-output/extras.txt
	@ ./count-todo -cto > test-output/extras.txt
	@ grep -q "[0-9a-f]\+,[^,]\+[^,]$$" test-output/extras.txt || (echo "'test-extras' failed: Expected commit hash, timestamp" && exit 1)
	@ echo "'test-extras' passed"

test-all:
	@ mkdir -p test-output
	@ rm -rf test-output/all.txt
	@ ./count-todo -ctal -d ./test > test-output/all.txt
	@ grep -q "[0-9a-f]\+,[^,]\+,0" test-output/all.txt || (echo "'test-all' failed: Expected commit hash, timestamp, and count (0)" && exit 1)
	@ grep -q "[0-9a-f]\+,[^,]\+,9" test-output/all.txt || (echo "'test-all' failed: Expected commit hash, timestamp, and count (9)" && exit 1)
	@ grep -q "[0-9a-f]\+:example.ts" test-output/all.txt || (echo "'test-all' failed: Expected commit hash in front of filename 'example.ts'" && exit 1)
	@ echo "'test-all' passed"
