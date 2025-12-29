#!/usr/bin/env bash

set -euo pipefail

FONT_SIZE=9
TERM_CLASS="nvim-wl-anywhere"
TERM="kitty"
TERM_OPTS="-o font_size=$FONT_SIZE --class $TERM_CLASS -e"
TMPFILE_DIR="/tmp/nvim-wl-anywhere"

kill_existing_instance() {
  local FOUND=false
  while read -r pid cmd; do
    if [[ "$cmd" == "$TERM"* ]]; then
      kill -9 "$pid"
      FOUND=true
    fi
  done < <(pgrep -af "$TERM_CLASS")

  if $FOUND; then
    echo "An existing instance was found and terminated."
    exit 1
  fi
}

create_tmpfile() {
  mkdir -p "$TMPFILE_DIR"
  local filename="tmp"
  TMPFILE="$TMPFILE_DIR/$filename"
  touch "$TMPFILE"
  chmod og-rwx "$TMPFILE"
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
    --font-size)
      if [[ $# -ge 2 && $2 != --* ]]; then
        FONT_SIZE="$2"
        shift 2
      else
        echo "Error: --font-size requires a value."
        exit 1
      fi
      ;;

    --term)
      if [[ $# -ge 2 && $2 != --* ]]; then
        TERM="$2"
        shift 2
      else
        echo "Error: --term requires a value."
        exit 1
      fi
      ;;

    --term-opts)
      TERM_OPTS=""
      shift
      while [[ $# -gt 0 && $1 != --* ]]; do
        TERM_OPTS="$TERM_OPTS $1"
        shift
      done
      ;;

    *)
      echo "Unknown argument: $1"
      show_help
      exit 1
      ;;
    esac
  done
}

kill_existing_instance
parse_args "$@"
create_tmpfile

sleep 0.2
OLD_SELECTION=$(wl-paste -p --no-newline || true)
wtype -M ctrl -k a -m ctrl
for i in {1..5}; do
  CURRENT_SELECTION=$(wl-paste -p --no-newline || true)
  if [[ "$CURRENT_SELECTION" != "$OLD_SELECTION" && -n "$CURRENT_SELECTION" ]]; then
    echo -n "$CURRENT_SELECTION" > "$TMPFILE"
    break
  fi
  sleep 0.1
done

# Launch Neovim in insert mode, auto-quit on write
$TERM $TERM_OPTS nvim +':set nocursorline nonu nornu noswapfile nobackup nowritebackup | set laststatus=0 scrolloff=999 | startinsert | autocmd BufWritePost <buffer> quit' "$TMPFILE"

TEXT=$(<"$TMPFILE")

# Paste the text
cat "$TMPFILE" | wl-copy -n
wtype -M Ctrl -k v -m Ctrl

rm -rf "$TMPFILE"
