#!/bin/bash
# Plum, alpha release
# Copyright 2018, Aswin Babu Karuvally


# install packages from package_list
install_packages() {
    cat package_list | while read package; do
        if [[ ! $package =~ \[[a-z]+\] ]] && [ ! -z $package ]; then
            apt-get install $package
        fi
    done
}


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
    # check if essential files exist
    essential_stuff

    # install the packages
    install_packages
}


# call the main function
main
