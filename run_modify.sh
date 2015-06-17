#!/bin/bash
#By Will

sbcl \
    --load modify-blog.asd  \
    --eval '(asdf:load-system :ext-blog)' \
    --eval '(ext-blog:main)'
