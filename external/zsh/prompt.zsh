autoload -Uz vcs_info

setopt nopromptsubst

local accent=$'\e[0;38;2;180;190;254m'
local dim=$'\e[2m'
local reset=$'\e[0m'
local newline=$'\n'

zstyle ':vcs_info:*' formats "${dim}%s( ${accent}%b${reset}${dim} )"
zstyle ':vcs_info:*' actionformats "${dim}%s( ${accent}%b${reset} | ${accent}%a${reset}${dim} )"
zstyle ':vcs_info:*' enable git

function precmd() {
  local last_status=$?
  local last_command=$(fc -ln -1 | awk '{print $1}')

  vcs_info

  local cwd="${PWD/#$HOME/~}"

  if [[ "${cwd:0:1}" == '/' ]]; then
    cwd="${accent}/${${cwd:1}//\//${reset} ${dim}» ${accent}}"
  elif [[ "${cwd:0:2}" == '~/' ]]; then
    cwd="${${cwd:2}//\//${reset} ${dim}» ${accent}}"
  else
    cwd="${${cwd//\//${reset} ${dim}» ${accent}}}"
  fi

  cwd="${accent}${cwd}${reset}"

  local baseprompt="${reset}${dim}%n${reset}${accent}@${reset}${dim}%m${reset}:${accent}%l${reset} ${dim}->${reset} ${cwd} ${dim}(${reset}%?${dim})${reset}${newline}"

  if [[ "$last_command" == 'cat' || "$last_command" == 'head' || "$last_command" == 'tail' || "$last_command" == 'tac' || "$last_command" == 'nc' || "$last_command" == 'ncat' || "$last_command" == 'netcat' ]]; then
    baseprompt+='😻'
  elif [[ "$last_command" == 'sudo' ]]; then
    baseprompt+='🙀'
  elif (( last_status == 0 )); then
    baseprompt+='😺'
  else
    baseprompt+='😿'
  fi

  baseprompt+=' '

  if [[ -z "$vcs_info_msg_0_" ]]; then
    PROMPT="${baseprompt}"
  elif [[ -n "$(git diff --cached --name-status 2>/dev/null)" ]]; then
    PROMPT="${vcs_info_msg_0_}${reset} COMMIT ${newline}${baseprompt}"
  elif [[ -n "$(git diff --name-status 2>/dev/null)" ]]; then
    PROMPT="${vcs_info_msg_0_}${reset} DIRTY ${newline}${baseprompt}"
  else
    PROMPT="${vcs_info_msg_0_}${newline}${baseprompt}"
  fi
}
