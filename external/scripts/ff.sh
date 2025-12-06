#! /usr/bin/env bash

set -euo pipefail

if [[ "${FF_SKIP:-}" != "" ]]; then
  exit 0
fi

kitget_output="$(mktemp --suffix=-kitget.png)"
trap 'rm -f -- "$kitget_output"' EXIT

c1=$'\e[1;38;2;180;190;254m'
c2=$'\e[1;38;2;203;166;247m'
nc=$'\e[0m'

ascii_logo() {
  local c1="$1"
  local c2="$2"
  cat <<EOF
${c1}  ▗▄   ${c2}▗▄ ▄▖
${c1} ▄▄🬸█▄▄▄${c2}🬸█▛ ${c1}▃
${c2}   ▟▛    ▜${c1}▃▟🬕
${c2}🬋🬋🬫█      ${c1}█🬛🬋🬋
${c2} 🬷▛🮃${c1}▙    ▟▛
${c2} 🮃 ${c1}▟█🬴${c2}▀▀▀█🬴▀▀
${c1}  ▝▀ ▀▘   ${c2}▀
EOF
}

header="${c1}ᓚ₍ ^. .^₎                ₍^. .^ ₎ᓗ${nc}"
stats_header="${c2}╭─────────────────────────────────╮${nc}"
stats_footer="${c2}╰─────────────────────────────────╯${nc}"

get_uptime() {
  if [[ -r /proc/uptime ]]; then
    local seconds total d h m s
    seconds=$(cut -d ' ' -f1 </proc/uptime)
    total=${seconds%.*}
    d=$((total / 86400))
    h=$(((total % 86400) / 3600))
    m=$(((total % 3600) / 60))
    s=$((total % 60))
    local parts=()
    ((d > 0)) && parts+=("${d}d")
    ((h > 0)) && parts+=("${h}h")
    ((m > 0)) && parts+=("${m}m")
    ((s > 0)) && parts+=("${s}s")
    printf '%s\n' "${parts[*]}"
  else
    uptime | cut -d ' ' -f 2
  fi
}

get_distro() {
  local name="" version=""
  # shellcheck disable=SC1091
  . /etc/os-release
  name="${NAME:-}"
  version="${VERSION_ID:-${VERSION:-}}"
  printf '%s%s%s\n' "${name}" "${version:+ }" "${version}"
}

stats_names=(
  "  user"
  "  host"
  "  uptime"
  "  distro"
  "  kernel"
)

stats_data=(
  "$(id -un 2>/dev/null || whoami)"
  "$(hostnamectl --static 2>/dev/null || hostname)"
  "$(get_uptime)"
  "$(get_distro)"
  "$(uname -sr)"
)

stats_padding=0
for name in "${stats_names[@]}"; do
  ((${#name} > stats_padding)) && stats_padding=${#name}
done
stats_padding=$((stats_padding + 1))

print_stat() {
  local i="$1"
  if ((i == 0)); then
    printf '%s\n' "$stats_header"
    return 1
  fi

  local name="${stats_names[i - 1]:-}"
  local data="${stats_data[i - 1]:-}"

  if [[ -n "$data" ]]; then
    printf '  %s' "${c1}${name}${nc}"
    local x
    for ((x = ${#name}; x < stats_padding; x++)); do
      printf ' '
    done
    printf ': %s\n' "$data"
  else
    printf '%s\n' "$stats_footer"
  fi
}

printf '\n\n'

use_kitget=true
if [[ "${FF_NO_KITGET:-}" != "" ]]; then
  use_kitget=false
elif ! command -v kitget >/dev/null 2>&1; then
  use_kitget=false
fi

if "$use_kitget" && kitget --square -o "$kitget_output" >/dev/null 2>&1; then
  if command -v kitty >/dev/null 2>&1; then
    clear
    kitty +kitten icat --place 22x22@2x1 --scale-up=yes --no-trailing-newline "$kitget_output"
    printf '\n'
    padding=26
    for ((i = 0; i < padding; i++)); do printf ' '; done
    printf '%s\n' "$header"

    for ((i = 0; i < padding; i++)); do printf ' '; done
    print_stat 0 || true

    for i in "${!stats_names[@]}"; do
      for ((x = 0; x < padding; x++)); do printf ' '; done
      print_stat "$((i + 1))" || continue
    done

    for ((x = 0; x < padding; x++)); do printf ' '; done
    printf '%s\n\n' "$stats_footer"
  else
    readarray -t logo <<<"$(ascii_logo "$c1" "$c2")"
    readarray -t logo_raw <<<"$(ascii_logo "" "")"

    padding=0
    for i in "${!logo_raw[@]}"; do
      ((${#logo_raw[i]} > padding)) && padding=${#logo_raw[i]}
    done
    padding=$((padding + 2))

    for ((i = 0; i < padding + 2; i++)); do printf ' '; done
    printf '%s\n' "$header"

    for i in "${!logo[@]}"; do
      printf '  %s' "${logo[i]}"
      for ((x = ${#logo_raw[i]}; x < padding; x++)); do printf ' '; done
      print_stat "$i" || continue
    done
  fi
else
  readarray -t logo <<<"$(ascii_logo "$c1" "$c2")"
  readarray -t logo_raw <<<"$(ascii_logo "" "")"

  padding=0
  for i in "${!logo_raw[@]}"; do
    ((${#logo_raw[i]} > padding)) && padding=${#logo_raw[i]}
  done
  padding=$((padding + 2))

  for ((i = 0; i < padding + 2; i++)); do printf ' '; done
  printf '%s\n' "$header"

  for i in "${!logo[@]}"; do
    printf '  %s' "${logo[i]}"
    for ((x = ${#logo_raw[i]}; x < padding; x++)); do printf ' '; done
    print_stat "$i" || continue
  done
fi

printf '\n'
