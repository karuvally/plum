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

    # check if package_list exists
    if [ ! -e package_list ]; then
        echo "error: package_list not found!"
        exit 1
    fi

    # check if configuration file exists
    if [ ! -e plumrc ]; then
        echo "error: plumrc not found!"
        exit 1
    fi
}


# the main function
main() {
    essential_stuff
}


# call the main function
main
