#!/bin/bash
# vim: ft=bash tw=80

function __conf {
   local DATA_FILE="${XDG_DATA_HOME:-${HOME}/.local/share/twce/conf}"/data

   local curr="${COMP_WORDS[$COMP_CWORD]}"
   local prev="${COMP_WORDS[$COMP_CWORD-1]}"

   local -a nicks=()
   local -a cmds=(
      --help
      help
      set
      cd
      sort
      clean
      db
      list
      edit
   )

   if (( COMP_CWORD == 1 )) ; then
      COMPREPLY=( $(compgen -W "${cmds[*]}" -- "${curr}") )
      return
   fi

   mapfile -t possible < <(
      compgen -W "${cmds[*]}" -- "$prev"
   )

   if (( ${#possible[@]} == 1 )) ; then
      prev="${possible}" 
   fi

   if [[ $prev == help ]] ; then
      unset 'cmds[1]' 'cmds[0]'
      COMPREPLY=( $(compgen -W "${cmds[*]}" -- "${curr}") )
   elif [[ $prev =~ (set|cd|edit|,|\.) ]] ; then
      local line
      while IFS=$'\n' read -r line ; do
         [[ $line =~ ^[[:space:]]*# ]]   && continue
         [[ $line =~ ^([^[:space:]]+) ]] && nicks+=( "${BASH_REMATCH[1]}" )
      done < "$DATA_FILE"
      COMPREPLY=( $(compgen -W "${nicks[*]}" -- "${curr}") )
   fi
}

complete -F __conf conf