

# PS1 customization ##############################################################################

c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_yellow=`tput setaf 3`
c_blue=`tput setaf 4`
c_purple=`tput setaf 5`
c_cyan=`tput setaf 6`
c_white=`tput setaf 7`
c_gray=`tput setaf 8`
c_sgr0=`tput sgr0`

parse_git_branch ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  else
    return 0
  fi
  echo -e $gitver
}

#http://www.entropy.ch/blog/Developer/2009/03/30/Git-and-SVN-Status-in-the-Bash-Prompt.html
parse_svn_revision() {
	local DIRTY REV=$(svn info 2>/dev/null | grep Revision | sed -e 's/Revision: //')
	[ "$REV" ] || return
	[ "$(svn st)" ] && DIRTY=' *'
	echo "r$REV$DIRTY"
}
branch_color ()
{
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    color=""
    if git diff --quiet 2>/dev/null >&2
    then
      color="${c_green}"
    else
      color=${c_red}
    fi
  else
    return 0
  fi
  echo -ne $color
}

#New in Bash 4 - http://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#index-PROMPT_005fDIRTRIM-226
export PROMPT_DIRTRIM='3'

PS1='[\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]$(parse_svn_revision)] \u\[${c_gray}\]@\[${c_blue}\]\w\[${c_sgr0}\]: '

# bash customization ##############################################################################

shopt -s histappend                     # merge history from multiple terminal
unset HISTFILESIZE                      # no file size limit
HISTSIZE=1000000                        # bigger history limit
HISTCONTROL=ignoreboth                  # ignore cmd that start with a space and duplicate cmd
HISTIGNORE='ls:bg:fg:history'

# cygwin customization ##############################################################################

set bell-style none
# to show all characters like åäö
set meta-flag On
set input-meta On
set output-meta On
set convert-meta Off


