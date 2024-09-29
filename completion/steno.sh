#!/bin/bash
# shellcheck disable=SC2207

function __steno {
   local curr="${COMP_WORDS[$COMP_CWORD]}"
   local prev="${COMP_WORDS[$COMP_CWORD-1]}"

   local -a cmds=( cd print )
   if (( COMP_CWORD == 1 )) ; then
      COMPREPLY=( $(compgen -W "${cmds[*]}" -- "$curr") )
      return
   fi

   if [[ $prev == 'print' ]] ; then
      if [[ ! "$curr" ]] ; then
         compopt -o nospace
         COMPREPLY=( ~/hg/crah/lesson_notes/ )
      else
         compopt -o default ; return
      fi
   fi
}

complete -F __steno steno
