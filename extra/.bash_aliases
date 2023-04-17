alias vi=nvim
alias cht=cht.sh
alias tmux="TERM=screen-256color-bce tmux"
alias tsn="ts-node"
alias kts="kotlinc-jvm -script"
alias rs="rust-script"

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

cheat() {
    curl "cheat.sh/$1/$2"
}

cap() {
    ansi2txt | xsel -ib && xsel -ob
}

clip() {
    ansi2txt | xsel -ib
}

cdd() {
    if [ -z $1 ]; then
        : # do nothing
    elif [ -d $1 ]; then
        cd $1
    elif [ -f $1 ]; then
        cd $(dirname $1)
    fi
}

cd_and_vi() {
    if [ -z $1 ]; then
        : # do nothing
    elif [ -f $1 ]; then
        cdd $1
        nvim $(basename $1)
    fi
}

# params: dir, types, pattern
fuzzy_find() {
    find_query=""
    fzf_query=""
    if [ ! -z $3 ]; then
        find_query="-ipath *$3*"
        fzf_query="--query $3"
    fi
    echo `find $1 -type $2 $find_query | fzf $fzf_query`
}

ffind() {
    dir=$1
    if [ -z $dir ]; then
        dir="."
    fi
    fuzzy_find $1 f $2
}

fim() {
    cd_and_vi $(fuzzy_find . f $1)
}

fima() {
    cd_and_vi $(fuzzy_find ~ f $1)
}

fd() {
    cdd $(fuzzy_find . d,f $1)
}

fda() {
    cdd $(fuzzy_find ~ d,f $1)
}

fdd() {
    cdd $(fuzzy_find . d $1)
}

fdda() {
    cdd $(fuzzy_find ~ d $1)
}

