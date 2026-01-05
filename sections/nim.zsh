#
# Nim
#
# Nim is a statically typed compiled systems programming language.
# Link: https://nim-lang.org/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_NIM_SHOW="${SPACESHIP_NIM_SHOW=true}"
SPACESHIP_NIM_ASYNC="${SPACESHIP_NIM_ASYNC=true}"
SPACESHIP_NIM_PREFIX="${SPACESHIP_NIM_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_NIM_SUFFIX="${SPACESHIP_NIM_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_NIM_SYMBOL="${SPACESHIP_NIM_SYMBOL="👑 "}"
SPACESHIP_NIM_COLOR="${SPACESHIP_NIM_COLOR="yellow"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of Nim
spaceship_nim() {
  [[ $SPACESHIP_NIM_SHOW == false ]] && return

  # Show Nim section only if there are Nim-specific files in current directory
  local is_nim_project="$(spaceship::upsearch nim.cfg)"
  [[ -n "$is_nim_project" || -n *.nim(#qN^/) || -n *.nims(#qN^/) || -n *.nimble(#qN^/) || -f nim.cfg ]] || return

  spaceship::exists nim || return

  local nim_version=$(nim --version | head -n 1 | cut -d ' ' -f 4)

  spaceship::section \
    --color "$SPACESHIP_NIM_COLOR" \
    --prefix "$SPACESHIP_NIM_PREFIX" \
    --suffix "$SPACESHIP_NIM_SUFFIX" \
    --symbol "$SPACESHIP_NIM_SYMBOL" \
    "v$nim_version"
}
