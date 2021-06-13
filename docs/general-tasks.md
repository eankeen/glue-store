# General Recepies for Tasks

Common task identifiers like 'build', 'docs', 'lint' are common across languages. This document lists them with some explanations. Depending on the project type, some commands may accept flags. For example, use `glue cmd docs -- --help` to show the help, if applicable

## docs

Simply builds docs using context-specific, specialized tools (ex. shdoc, godoc, TypeDoc, rustdoc)

## lint

Simply lints code using context-specific, specialized tools (ex. ShellCheck, golangci-lint, ESlint, Clippy)

## test

Simply tests code using context-specific, specialized tools (ex. Bats, gotest, Jest, cargo test)

## build

First and foremost, the version is incremented in `glue.toml`, along with any more specialized version identifiers within the codebase, if they exist

Then, the code is build using context-specific specialized tools (ex. go build, tsc, cargo build)

# run

If there is a run script specialized for development (ex. development server), it executes that script. If not, the program is ran normally

Note that the program is _not_ manually built before running

## release

Note: All releases are dry by default. To actually perform the release and commit on actions that cannot resonably be undone (GitHub artifact release, AUR uploading), pass `--wet` (ex. `glue cmd release -- --wet`); otherwise, these steps will be skipped. Furthermore, when in dry mode, some behavior (below) that specifies to bail the release process may, in fact, not; a warning will be printed instead.

1. Check to ensure the current project
  - Is a git repository
  - Any changes are only version increments (although we could ensure the working tree is _completely_ clean, it's not really necessary since the version will be incremented later)
  - The local and remote Git history are shared (no force pushing)

2. First and foremost, the tasks `docs`, `lint` `build`, and `test` that match the specified project type are ran, in order. If any of them fail, then bail on the release

3. Then, the Git working tree _must be_ checked to ensure that _only_ version increments have been performed (which is part of the `build` process). If other changes have been made to the working tree, bail

# TODO: create new version automatically

4. After, prompt the user for a new version string, based off the current version. With this version, increment the version in `glue.toml`, along with any more specialized version identifiers within the codebase, if they exist

5. Then, the Git working tree _must be_ checked to ensure that _only_ version increments have been performed (part of the `build` process). If other changes have been made, bail

6. Changelog: Afterwards, generate any relevant changelog (`CHANGELOG.md`) files.

7. Git tag: Git Commit all changes (which should only be version increments and changelog files at this point) and generate a commit for the release

8. Github release: Create a GitHub release, uploading any context-specific artifacts (ex. signed and checksumed binaries)

9. Any other miscellaneous distribution steps for the generated artifacts. This may include, but is not limited to:
  - Programming language package manager bundling and uploading
  - Linux distribution package manager package bundling and uploading
  - Docker/OCI image bundling and uploading

## deploy

Simply deploys code using one or more specialized tools (ex. Terraform, Ansible, Vercel)

## ci

Simply run the CI tests locally, if possible
