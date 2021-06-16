FROM archlinux

# TODO
LABEL \
	org.opencontainers.image.authors="edwin@kofler.dev" \
	org.opencontainers.image.url="TODO" \
	org.opencontainers.image.documentation="TODO" \
	org.opencontainers.image.source="TODO" \
	org.opencontainers.image.version="TODO" \
	org.opencontainers.image.revision="TODO" \
	org.opencontainers.image.vendor="TODO" \
	org.opencontainers.image.licenses="TEMPLATE_DOCKER_LICENSE" \
	org.opencontainers.image.title="Documentation with mkdocs" \
	org.opencontainers.image.description="Uses 'mkdocs' to build documentation"

RUN pacman -Sy --noconfirm python poetry git

RUN useradd -ms /bin/bash op
USER op
WORKDIR /home/op

RUN poetry init \
		--name "TEMPLATE_POETRY_NAME" \
		--description "TEMPLATE_POETRY_DESCRIPTION" \
		--author "TEMPLATE_POETRY_AUTHOR" \
		--license  "TEMPLATE_POETRY_LICENSE" \
		--no-interaction \
	&& poetry add \
		mkdocs mkdocs-material \
		mkdocs-git-revision-date-localized-plugin \
		mike mkdocs-mermaid2-plugin mkdocs-macros-plugin

COPY --chown=op:op docs ./docs
COPY --chown=op:op mkdocs.yml ./

CMD [ "/usr/bin/bash", "-c", "poetry run mkdocs build" ]
