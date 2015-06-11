#!/bin/bash
#By Will

sbcl \
    --load ext-blog.asd  \
    --eval '(asdf:load-system :ext-blog)' \
    --eval '(ext-blog:start :port 11011)'
