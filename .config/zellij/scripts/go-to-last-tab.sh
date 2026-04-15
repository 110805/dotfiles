#!/bin/bash
count=$(zellij action dump-layout | grep -cE '^\s+tab(\s|\{|$)')
zellij action go-to-tab "$count"
