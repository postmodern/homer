#!/usr/bin/env bats

load test_helper

assert_error() {
  assert_output "ERROR: $1"
}

if [ -z "$HOMER_TEST_REPO_URL" ]; then
  HOMER_TEST_REPO_URL=https://github.com/tubbo/home.git
fi

@test "initialize a git repo as the home dir" {
  export HOMER_HOME="$BATS_TMPDIR/home"
  rm -rf $HOMER_HOME
  mkdir -p $HOMER_HOME

  run $PWD/bin/homer init

  assert_success
  assert_file_exist $HOMER_HOME/etc/aliases.zsh
  assert_file_exist $HOMER_HOME/etc/plugins.zsh
  assert_file_exist $HOMER_HOME/bin/.keep
}

@test "clone an existing git repo into the home dir" {
  export HOMER_HOME="$BATS_TMPDIR/home"
  rm -rf $HOMER_HOME
  mkdir -p $HOMER_HOME

  run $PWD/bin/homer init $HOMER_TEST_REPO_URL

  assert_success
  assert_file_exist $HOMER_HOME/etc/aliases.zsh
  assert_file_exist $HOMER_HOME/etc/plugins.zsh
  assert_file_exist $HOMER_HOME/bin/.keep
}

@test "print an error and exit if git repo already exists" {
  export HOMER_HOME="$BATS_TMPDIR/home"
  rm -rf $HOMER_HOME
  mkdir -p $HOMER_HOME/.git

  run $PWD/bin/homer init

  assert_failure
  assert_error "There is already an existing Git repository in $HOMER_HOME."
}
