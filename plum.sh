#!/bin/bash
# Plum, alpha release
# Copyright 2018, Aswin Babu Karuvally


# check essential stuff
essential_stuff() {
    # check if root
    if [ `id -u` -ne 0 ]; then
        echo "error: run plum as root!"
        exit 1
    fi
}


# the main function
main() {
    essential_stuff
}


# call the main function
main
