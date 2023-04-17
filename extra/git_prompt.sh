parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
if [ "$color_prompt" = yes ]; then
    PS1="\[\033[01;34m\]\w\[\033[36m\]\$(parse_git_branch)\[\033[35m\] $ \[\033[00m\]"
else
    PS1="\w\$(parse_git_branch) $ "
fi

