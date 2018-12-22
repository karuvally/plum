#!/bin/bash
# Plum, alpha release
# Copyright 2018, Aswin Babu Karuvally


# display the help screen
print_help() {
    printf "Usage: ./plum.sh [install] [-h] [+/- category]\n"
    printf "\tinstall\t start package installation\n"
    printf "\t-h\t\t show this help screen\n"
    printf "\t+category\t install only packages under category\n"
    printf "\t-category\t exclude packages in category\n"
}


# process command line arguments
process_args() {
    for argument in "$@"; do
        case $argument in
            install)
                echo "installing packages..."
                install_packages
                ;;

            -h)
                print_help()

            *)
                echo "error: unknown command"
                ;;
        esac
    done
}


# install packages from package_list
install_packages() {
    # update the repos
    $cmd_package_manager $cmd_update

    # generate package string
    package_string=""
    while read package; do
        if [[ ! $package =~ \[[a-z]+\] ]] && [ ! -z $package ]; then
            package_string+=" $package"
        fi
    done <<< `cat package_list`

    # do the actual installation
    $cmd_package_manager $cmd_install $unattended_switch $package_string
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

    # show help if empty arguments
    if [ -z "$@" ]; then
        print_help
    fi 

    # process command line args
    process_args "$@"
}


# call the main function with args
main "$@"
