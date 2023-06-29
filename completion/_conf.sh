#!/bin/bash
# vim: ft=bash tw=80

declare -g DATA_FILE="${XDG_DATA_HOME:-${HOME}/.local/share/twce/conf}"/data
declare -g DATA_DIR="${DATA_FILE%/*}"

function _CONF_COMP_MAIN {
   local -a opts

   while IFS=$'\n' read -r line ; do
      # Comments.
      if [[ $line =~ ^[[:space:]]*# ]] ; then
         continue
      fi

      # Nicknames.
      if [[ $line =~ ^([^[:space:]]+) ]] ; then
         opts+=( "${BASH_REMATCH[1]}" )
      fi
   done < "$DATA_FILE"

   COMPREPLY=( $(compgen -W "${opts[*]}" -- "${COMP_WORDS[$COMP_CWORD]}" ) )
}

complete -F _CONF_COMP_MAIN conf
