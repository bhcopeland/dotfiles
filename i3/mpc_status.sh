mpc status | perl -ne 'if (/\[playing\]/) {CORE::say (`mpc current|tr -d "\n"`)}'| gawk '{ gsub(/"/,"\\\"") } 1'
