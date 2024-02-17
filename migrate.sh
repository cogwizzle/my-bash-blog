#!/bin/bash

scripts/drop
scripts/up

scripts/write -f content/you-dont-need-react.md
scripts/write -f content/library-bloat.md
scripts/write -f content/cplusplus-from-js-dev.md

sqlite3 blog.db 'update blog set date = "2021-10-27" where id = 1'
sqlite3 blog.db 'update blog set date = "2021-10-30" where id = 2'
sqlite3 blog.db 'update blog set date = "2023-04-18" where id = 3'

scripts/generate -i 1
scripts/generate -i 2
scripts/generate -i 3
scripts/index
