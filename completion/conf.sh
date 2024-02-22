#!/bin/bash
# vim: ft=bash tw=80
#
# shellcheck disable=SC2207

function __conf {
   local DATA_FILE="${XDG_DATA_HOME:-$HOME}/.local/share/twce/conf"/data

   local curr="${COMP_WORDS[$COMP_CWORD]}"
   local prev="${COMP_WORDS[$COMP_CWORD-1]}"

   local -a cmds=(
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

   # Kinda niche case. Gives file completion in cases like:
   #> conf set asfd ___
   #                ^^^
   if [[ ${COMP_WORDS[1]} == 'set' ]] &&
      (( COMP_CWORD > 2 ))
   then
      # Little hacky. Sets default `readline` completion if using `set` for path
      # names.
      compopt -o default ; return
   fi

   mapfile -t possible < <(
      compgen -W "${cmds[*]}" -- "$prev"
   )

   if (( ${#possible[@]} == 1 )) ; then
      prev="$possible" 
   fi

   if [[ $prev == help ]] ; then
      unset 'cmds[0]' # no `help help` allowed.
      COMPREPLY=( $(compgen -W "${cmds[*]}" -- "${curr}") )
   elif
      (( COMP_CWORD == 2 )) &&
      [[ $prev =~ ^(set|cd|edit|,|\.)$ ]]
   then
      local -a nicks=()
      local line
      while IFS=$'\n' read -r line ; do
         [[ $line =~ ^[[:space:]]*#   ]] && continue
         [[ $line =~ ^([^[:space:]]+) ]] && nicks+=( "${BASH_REMATCH[1]}" )
      done < "$DATA_FILE"
      COMPREPLY=( $(compgen -W "${nicks[*]}" -- "${curr}") )
   fi
}

complete -F __conf conf
