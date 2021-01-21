#!/bin/bash

function get_album_info {
    while read line;
    do
        echo "$line"
    done < "beatles_songs.info.txt" | cut -f2-3 | uniq | cat
}

function get_album_songs {
    if grep -q "$1$" "beatles_songs.info.txt"; then
    echo -e "songs in $1:\n"
    cat "beatles_songs.info.txt" | grep -h "$1$" | cut -f1
    else
        echo -e "Album did not found\n"
    fi    
}

function get_song_lyrics {
    if [ -f $"./beatles.lyrics/`echo ${1// /} | tr A-Z a-z | cat`.txt" ]; then
        cat "./beatles.lyrics/`echo ${1// /} | tr A-Z a-z | cat`.txt"
    else
        echo "the song - $1 : did not found"
    fi
}

function Usage {
    if [ -z "$1" ]; then
    echo -e "Usage: ./beatles.sh <command>\n"
    echo -e "Commands:"
    echo -e "info\t\tList all Beatles albums"
    echo -e "songs <album-name> List songs in album <album-name>"
    echo -e "lyrics <song-name> Print words for song <song-name>\n"
    else
    echo -e "Error: unknown command: $1\n"
    echo -e "Usage: ./beatles.sh <command>\n"
    echo -e "Commands:"
    echo -e "info\t\tList all Beatles albums"
    echo -e "songs <album-name> List songs in album <album-name>"
    echo -e "lyrics <song-name> Print words for song <song-name>\n"
    fi
}

if [[ $1 = "info" ]] ; then
    get_album_info
elif [[ $1 = "songs" ]] ; then
    get_album_songs "$2"
elif [[ $1 = "lyrics" ]] ; then
    get_song_lyrics "$2"
else
    Usage "$1"
fi
