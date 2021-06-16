#!/usr/bin/env bash
eval "$GLUE_BOOTSTRAP"
bootstrap

action() {
	ensure.cmd 'docker'

	util.shopt -s globstar

	local exitCode=0

	toml.get_key 'gitRemoteUser' glue.toml
	local gitRemoteUser="$REPLY"
	ensure.nonZero 'gitRemoteUser' "$gitRemoteUser"

	toml.get_key 'gitRemoteRepo' glue.toml
	local gitRemoteRepo="$REPLY"
	ensure.nonZero 'gitRemoteRepo' "$gitRemoteRepo"

	toml.get_key 'description' glue.toml
	local description="$REPLY"
	ensure.nonZero 'description' "$description"

	toml.get_key 'license' glue.toml
	local tomlKeyLicense="$REPLY"
	ensure.nonZero 'tomlKeyLicense' "$tomlKeyLicense"

	# TODO: rename 'name' to 'author'? (or something else?)
	toml.get_key 'name' glue.toml
	local tomlKeyName="$REPLY"
	ensure.nonZero 'tomlKeyName' "$tomlKeyName"

	toml.get_key 'project' glue.toml
	local tomlKeyProject="$REPLY"
	ensure.nonZero 'tomlKeyProject' "$tomlKeyProject"

	# glue useConfig(tool-mkdocs)
	util.get_config 'tool-mkdocs/mkdocs.yml'
	local cfgMkdocsYml="$REPLY"

	util.get_config 'tool-mkdocs/Dockerfile'
	local cfgDockerfile="$REPLY"

	bootstrap.generated 'tool-mkdocs'; {
		ensure.cd "$GENERATED_DIR"

		cp "$cfgMkdocsYml" "$cfgDockerfile" .

		sed -i \
			-e "s/TEMPLATE_SITE_NAME/$tomlKeyProject/g" \
			-e "s/TEMPLATE_REMOTE_USER/$gitRemoteUser/g" \
			-e "s/TEMPLATE_REMOTE_REPO/$gitRemoteRepo/g" \
			-e "s/TEMPLATE_DESCRIPTION/$description/g" \
			-e "s/TEMPLATE_AUTHOR/$tomlKeyProject/g" \
			mkdocs.yml

		sed -i \
			-e "s/TEMPLATE_POETRY_NAME/$tomlKeyProject/g" \
			-e "s/TEMPLATE_POETRY_DESCRIPTION/$description/g" \
			-e "s/TEMPLATE_POETRY_AUTHOR/$tomlKeyName/g" \
			-e "s/TEMPLATE_POETRY_LICENSE/$tomlKeyLicense/g" \
			-e "s/TEMPLATE_DOCKER_LICENSE/$tomlKeyLicense/g" \
			Dockerfile

		# Copy current documentation
		mkdir -p docs
		cp "$GLUE_WD"/docs/* ./docs
		ensure.file "$GLUE_WD/README.md"
		cp "$GLUE_WD/README.md" 'docs/index.md'

		# Copy specialized files to 'docs' before build
		util.run_hook 'hook.tool-mkdocs.copy_docs'

		ls -al
		docker build -t 'tool-mkdocs-poetry:default' .
		docker run -it --name 'tool-mkdocs-poetry-container' 'tool-mkdocs-poetry:default'
		docker container cp 'tool-mkdocs-poetry-container:/home/op/site' 'site'
		docker container rm -f 'tool-mkdocs-poetry-container'

		ensure.cd site
		git init --initial-branch=main
		git add -A
		git commit -m 'tool-mkdocs.sh: Update site'
		# # TODO: rebase or configure merge strategy to preserve history
		git push -f "https://github.com/$gitRemoteUser/$gitRemoteRepo.git" main:gh-pages
	}; unbootstrap.generated

	REPLY="$exitCode"
}

action "$@"
unbootstrap
