#!/bin/sh

marco(){
    # we need to export so other functions can access marcoPath
    marcoPath="$(pwd)"
    export marcoPath
}

polo(){
    cd "$marcoPath" || exit
}
