alias tmux="TERM=screen-256color-bce tmux"
alias tsn="ts-node"
alias kts="kotlinc-jvm -script"

touchscript() {
    if [[ ! -f $1 ]]; then
        if [[ $1 =~ .*\.sh ]]; then
            echo -e "#!/usr/bin/env bash\n" > "$1"
            chmod u+x "$1"
        elif [[ $1 =~ .*\.ts ]]; then
            echo -e "#!/usr/bin/env ts-node\n" > "$1"
            chmod u+x "$1"
        elif [[ $1 =~ .*\.py ]]; then
            echo -e "#!/usr/bin/env python3\n" > "$1"
            chmod u+x "$1"
        elif [[ $1 =~ .*\.kts ]]; then
            echo -e "#!/usr/bin/env -S kotlinc-jvm -script\n" > "$1"
            chmod u+x "$1"
        else
            /usr/bin/touch "$1"
        fi
    fi
}

ktc() {
    if [[ $1 =~ .*\.kt ]]; then
      kotlinc-jvm $1 -d ${1/%kt/jar}
    else
      kotlinc-jvm $1 -d $1.jar
    fi
}

kot() {
    kotlin -classpath $1 ${1/%\.jar/Kt}
}


