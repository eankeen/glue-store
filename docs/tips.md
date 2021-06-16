# Tips

Consider the following

## Use Linter

`./scripts/lint.sh`

## Avoid explicit subshells

Consider this `action`:

```bash
#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	ensure.cmd 'toast'

	local exitCode=0

	bootstrap.generated 'tool-mkdocs'; (
		ensure.cd "$GENERATED_DIR"

		# Intermediary commands hidden for brevity

		toast mkdocs
	); exitCode=$?; unbootstrap.generated

	REPLY="$exitCode"
}

action "$@"
unbootstrap
```

If `toast mkdocs` errors, then the callstack is printed like so:

```txt
[INFO] Running task mkdocs…
[ERROR] Error appending data to tar archive. Reason: paths in archives must not have `..` when setting path for scratch
CALLSTACK
=> tool-mkdocs.sh:action()
  => tool-shdoc.sh:action()
    => Bash.docs.sh:task()
CALLSTACK
=> tool-mkdocs.sh:action()
  => tool-shdoc.sh:action()
    => Bash.docs.sh:task()
```

Without `set -E`, the callstack is not printed at all! So don't use subshells explicitly if you don't have to. The EXIT trap and `unbootstrap.generated` already automatically change directory back to the original directory (`$GLOBAL_ORIGINAL_WD`)
