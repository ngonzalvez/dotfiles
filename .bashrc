#
#                       ██████   █████  ███████ ██   ██
#                       ██   ██ ██   ██ ██      ██   ██
#                       ██████  ███████ ███████ ███████
#                       ██   ██ ██   ██      ██ ██   ██
#                       ██████  ██   ██ ███████ ██   ██
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#################################################################
# TERMCAP Setup
#################################################################
# enter blinking mode - red
export LESS_TERMCAP_mb=$(printf '\e[01;31m')
# enter double-bright mode - bold, magenta
export LESS_TERMCAP_md=$(printf '\e[01;35m')
# turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_me=$(printf '\e[0m')
# leave standout mode
export LESS_TERMCAP_se=$(printf '\e[0m')
# enter standout mode - green
export LESS_TERMCAP_so=$(printf '\e[01;32m')
# leave underline mode
export LESS_TERMCAP_ue=$(printf '\e[0m')
# enter underline mode - blue
export LESS_TERMCAP_us=$(printf '\e[04;34m')


# PS1 Setup
# PROMPT_COMMAND=__prompt_command
# export PS1="\e[32m\$ \e[0m";
__prompt_command() {
    local EXITCODE="$?"

    local HOSTCOLOR="5"
    local USERCOLOR="3"
    local PATHCOLOR="4"

    if [ $EXITCODE == 0 ]; then
        PS1="\e[32m\$ \e[0m";
    else
        PS1="\e[31m\$ \e[0m";
    fi
}


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


#################################################################
# AUTO-COMPLETION
#################################################################
# NativeScript completion
if [ -f /home/ngonzalvez/.tnsrc ]; then
    source /home/ngonzalvez/.tnsrc
fi


#################################################################
# TERMINAL TITLE
#################################################################
case "$TERM" in
xterm*|rxvt*|screen*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac

# Load custom config.
source $HOME/.vars
source $HOME/.inputrc
source $HOME/.aliases
