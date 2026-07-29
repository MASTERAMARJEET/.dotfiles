# Generic directory-scoped environment switching.
# Config: workspaces.conf + workspaces/*.env (see .zsh_exports)

typeset -g _zsh_ws_current=""
typeset -gA _zsh_ws_saved
typeset -ga _zsh_ws_keys

_zsh_ws_expand_path() {
  local p="$1"
  [[ $p == ~* ]] && p="${p/#\~/$HOME}"
  print -r -- "$p"
}

_zsh_ws_env_file_path() {
  local ws_file="$1"
  local dir="${ZSH_WORKSPACES_DIR:-$HOME/.dotfiles/zsh/workspaces}"

  if [[ $ws_file == /* || $ws_file == ~* ]]; then
    print -r -- "$(_zsh_ws_expand_path "$ws_file")"
  else
    print -r -- "$dir/$ws_file"
  fi
}

_zsh_ws_restore() {
  local key

  for key in ${_zsh_ws_keys[@]}; do
    if (( ${+_zsh_ws_saved[$key]} )); then
      export "$key=${_zsh_ws_saved[$key]}"
    else
      unset "$key"
    fi
  done

  _zsh_ws_keys=()
  _zsh_ws_saved=()
  _zsh_ws_current=""
}

_zsh_ws_match() {
  local conf="${ZSH_WORKSPACES_CONF:-$HOME/.dotfiles/zsh/workspaces.conf}"
  local line ws_path ws_file expanded_path best_path="" best_file="" len=0 plen

  [[ -f "$conf" ]] || return 1

  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "${line//[[:space:]]/}" || "$line" == \#* ]] && continue

    ws_path="${line%%[[:space:]]*}"
    ws_file="${line#${ws_path}}"
    ws_file="${ws_file#"${ws_file%%[![:space:]]*}"}"

    [[ -n "$ws_path" && -n "$ws_file" ]] || continue

    expanded_path="$(_zsh_ws_expand_path "$ws_path")"

    if [[ $PWD == ${expanded_path}(|/*) ]]; then
      plen=${#expanded_path}
      if (( plen > len )); then
        len=$plen
        best_path="$expanded_path"
        best_file="$(_zsh_ws_env_file_path "$ws_file")"
      fi
    fi
  done < "$conf"

  REPLY_PATH="$best_path"
  REPLY_FILE="$best_file"
  [[ -n "$best_path" ]]
}

_zsh_ws_apply_env_file() {
  local file="$1" line key val

  _zsh_ws_keys=()

  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "${line//[[:space:]]/}" || "$line" == \#* ]] && continue

    line="${line#export }"
    key="${line%%=*}"
    key="${key%%[[:space:]]*}"
    val="${line#*=}"
    val="${val#"${val%%[![:space:]]*}"}"

    [[ -n "$key" ]] || continue

    if (( ${(P)+key} )); then
      _zsh_ws_saved[$key]="${(P)key}"
    fi

    _zsh_ws_keys+=("$key")
    export "$key=$val"
  done < "$file"
}

_zsh_ws_update() {
  local match_path="" match_file=""

  if _zsh_ws_match; then
    match_path="$REPLY_PATH"
    match_file="$REPLY_FILE"
  fi

  [[ "$match_path" == "$_zsh_ws_current" ]] && return 0

  _zsh_ws_restore

  [[ -z "$match_path" || ! -f "$match_file" ]] && return 0

  _zsh_ws_current="$match_path"
  _zsh_ws_apply_env_file "$match_file"
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _zsh_ws_update
_zsh_ws_update
