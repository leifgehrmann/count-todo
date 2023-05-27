install:
	ln -s `pwd`/count-todo /usr/local/bin/count-todo

uninstall:
	rm /usr/local/bin/count-todo

tests: test-basic test-list test-extras test-all
	@echo
	@echo "Success! All tests passed."
	@echo

test-basic:
	mkdir -p test-output
	rm -rf test-output/basic.txt
	./count-todo > test-output/basic.txt
	grep "12" test-output/basic.txt || (echo "Test Failed: Could not find '12'" && exit 1)

test-list:
	mkdir -p test-output
	rm -rf test-output/list.txt
	./count-todo -l -d ./test > test-output/list.txt
	grep "9" test-output/list.txt || (echo "Test Failed: Could not find '9'" && exit 1)
	grep "Optimise my code" test-output/list.txt || (echo "Test Failed: Cound not find 'Optimise my code'" && exit 1)
	grep "example.ts" test-output/list.txt || (echo "Test Failed: Could not find '^example.ts'" && exit 1)

test-extras:
	mkdir -p test-output
	rm -rf test-output/extras.txt
	./count-todo -cto > test-output/extras.txt
	grep "[0-9a-f]\+,[^,]\+[^,]$$" test-output/extras.txt || (echo "Test Failed: Expected commit hash, timestamp" && exit 1)

test-all:
	mkdir -p test-all
	rm -rf test-output/all.txt
	./count-todo -ctal -d ./test > test-output/all.txt
	grep "[0-9a-f]\+,[^,]\+,0" test-output/all.txt || (echo "Test Failed: Expected commit hash, timestamp, and count (0)" && exit 1)
	grep "[0-9a-f]\+,[^,]\+,9" test-output/all.txt || (echo "Test Failed: Expected commit hash, timestamp, and count (9)" && exit 1)
	grep "[0-9a-f]\+:example.ts" test-output/all.txt || (echo "Test Failed: Expected commit hash in front of filename" && exit 1)
