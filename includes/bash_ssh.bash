#!/bin/bash
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
fi

[ -f "$HOME/.ssh/id_rsa" ] || return;

ssh-add -l | grep id_rsa > /dev/null || ssh-add $HOME/.ssh/id_rsa
