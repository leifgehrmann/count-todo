![# TODO](hero.png)

# count-todo

Shell script to count the number of TODO, FIXME, and BUG comments in a git
repository.

The script can also:

* list all the files with comments,
* include the commit hash and commit date-time,
* count the number of comments over time by looping through all commits.

## Usage

```
% count-todo -h
Count the number of TODO, FIXME, and BUG comments in a git repository.

Usage: count-todo [-d <path>] [-lctoa]

Options:
  -d <path> Search a specific directory.
  -l        Include complete list of comments in output.
  -c        Include commit hash in output.
  -t        Include commit date-time in output.
  -o        Omit total count in output.
  -a        Iterate through all commits in the current branch.
```

## Examples

`count-todo` can be run in any git repository, or a specific sub-directory
using `-d`.

```
% count-todo
9
% count-todo -d ./src
3
```

The list of comments can displayed using `-l`.

```
% count-todo -d ./src -l  
3
index.html:    <!-- TODO: Add a favicon -->
app.tsx:  // Todo Add a contact form
functions.ts: * FIXME: Handle empty strings
```

A historical count of comments in the git log can be displayed using `-a`.
Commit hash and date-time can be added for context using `-c` and `-t` respectively.

```
% count-todo -act
0a756dff83c898b6e7fc46a5befea943995b6406,2023-05-27 11:21:30 +0100,9
2227bcccc550780a0c6ce785934b329fdbbd96e8,2023-05-26 10:00:32 +0100,8
23d56cb4652f621af3ac5e7cd6b3f93bcd664a75,2023-05-25 08:37:23 +0100,7
47d25b097f47050a7e96afc8a468ffbe1dbe8901,2023-05-24 13:24:31 +0100,4
816d47aff8d35536ffca25f70a247453ca7bc69c,2023-05-22 12:03:02 +0100,0
b5a3dbb340ef4dd4f0855894e88965fe4102198d,2023-05-21 12:57:25 +0100,0
5ba156613b8668c6d9d08a33039854b6b383165e,2023-05-20 10:22:18 +0100,0
```

## Installation

To install the script into your `/usr/local/bin`, run: 

```
% make install
```

To uninstall, run:

```
% make uninstall
```
