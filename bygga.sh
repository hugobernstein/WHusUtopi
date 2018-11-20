#!/bin/sh
racket make-page-tree.rkt
raco pollen render index.ptree
raco pollen render *.pm
