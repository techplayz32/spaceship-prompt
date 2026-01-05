#!/usr/bin/env zsh

# Required for shunit2 to run correctly
setopt shwordsplit
SHUNIT_PARENT=$0

# ------------------------------------------------------------------------------
# SHUNIT2 HOOKS
# ------------------------------------------------------------------------------

setUp() {
  # Enter the test directory
  cd $SHUNIT_TMPDIR
}

oneTimeSetUp() {
  export TERM="xterm-256color"
  export PATH=$PWD/tests/stubs:$PATH

  NIM_VERSION="2.2.6"

  SPACESHIP_PROMPT_ASYNC=false
  SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
  SPACESHIP_PROMPT_ADD_NEWLINE=false
  SPACESHIP_PROMPT_ORDER=(nim)

  source "spaceship.zsh"
}

oneTimeTearDown() {
  unset SPACESHIP_PROMPT_ASYNC
  unset SPACESHIP_PROMPT_FIRST_PREFIX_SHOW
  unset SPACESHIP_PROMPT_ADD_NEWLINE
  unset SPACESHIP_PROMPT_ORDER
}

# ------------------------------------------------------------------------------
# TEST CASES
# ------------------------------------------------------------------------------

test_nim_no_files() {
  local expected=""
  local actual="$(spaceship::testkit::render_prompt)"

  assertEquals "do not render if there are no files" "$expected" "$actual"
}

test_nim_files() {
  touch nim.cfg

  local expected=(
    "%{%B%}$SPACESHIP_NIM_PREFIX%{%b%}"
    "%{%B%F{$SPACESHIP_NIM_COLOR}%}"
    "$SPACESHIP_NIM_SYMBOL"
    "v$NIM_VERSION"
    "%{%b%f%}"
    "%{%B%}$SPACESHIP_NIM_SUFFIX%{%b%}"
  )
  local actual="$(spaceship::testkit::render_prompt)"

  assertEquals "render with nim.cfg" "${(j::)expected}" "$actual"
}

test_nim_extensions() {
  touch main.nim

  local expected=(
    "%{%B%}$SPACESHIP_NIM_PREFIX%{%b%}"
    "%{%B%F{$SPACESHIP_NIM_COLOR}%}"
    "$SPACESHIP_NIM_SYMBOL"
    "v$NIM_VERSION"
    "%{%b%f%}"
    "%{%B%}$SPACESHIP_NIM_SUFFIX%{%b%}"
  )
  local actual="$(spaceship::testkit::render_prompt)"

  assertEquals "render with main.nim" "${(j::)expected}" "$actual"
}

# ------------------------------------------------------------------------------
# SHUNIT2
# Run tests with shunit2
# ------------------------------------------------------------------------------

source tests/shunit2/shunit2
