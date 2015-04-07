#!/bin/bash
[ -f "$HOME/.ssh/id_rsa" ] || return;

if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
fi

ssh-add -l > /dev/null || ssh-add $HOME/.ssh/id_rsa
