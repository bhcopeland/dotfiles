#!/bin/awk -f

BEGIN {

    MPD_CMD = "mpc"; # mpd
    MPD_CMD | getline;
    MPD_CMD | getline;
    mpd_state = $1;
    close(MPD_CMD);

    if ( mpd_state == "[playing]" )
        print "${voffset 4}${font Webdings:size=14}4${font}   Song: $alignr$mpd_artist\n${voffset 6}$alignr$mpd_title\n${voffset 8}$mpd_elapsed/$mpd_length $alignr${mpd_bar 8,120}";
    else {
        if ( mpd_state == "[paused]" )
            print "${voffset 4}${font Webdings:size=14};${font}   Song: $alignr$mpd_artist\n${voffset 6}$alignr$mpd_title\n${voffset 8}$mpd_elapsed/$mpd_length $alignr${mpd_bar 8,120}";
    }

}
