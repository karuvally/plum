#!/bin/bash
# Plum, alpha release
# Copyright 2018, Aswin Babu Karuvally


# install packages from package_list
install_packages() {
    # update the repos
    $cmd_package_manager $cmd_update

    # do the actual installation
    cat package_list | while read package; do
        if [[ ! $package =~ \[[a-z]+\] ]] && [ ! -z $package ]; then
            apt-get install $package
        fi
    done
}


# do checks, load files
initialize_plum() {
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
    else
        source plumrc
    fi
}


# the main function
main() {
    # do essential checks and load stuff
    initialize_plum 

    # install the packages
    install_packages
}


# call the main function
main
