# glue-store

My personal store for [glue](https://github.com/eankeen/glue)

The contents of each folder is copied to the `auto` subdirectory for any project you manage with `glue`

## Usage

Glue doesn't have a distribution channel yet, so invoke it in a
cloned repository directory

```sh
# Example ($PWD is eankeen/glue-example)
../glue/glue.sh sync && ../glue/glue.sh cmd NodeJS_Server.build
```
