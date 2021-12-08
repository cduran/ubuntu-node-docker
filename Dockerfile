FROM ubuntu:focal

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ARG USERNAME=${USERNAME}
ENV USERNAME=${USERNAME}

ARG NVM_DIR=${NVM_DIR}
ENV NVM_DIR=${NVM_DIR}

ARG NODE_VERSION=${NODE_VERSION}
ENV NODE_VERSION=${NODE_VERSION}

ARG NVM_VERSION=${NVM_VERSION}
ENV NVM_VERSION=${NVM_VERSION}

RUN apt-get update -yq && apt-get upgrade -yq && \
	apt-get install -yq sudo curl git vim

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN useradd --create-home --shell /bin/bash ${USERNAME}
RUN adduser ${USERNAME} sudo
RUN [[ ! $(getent group nvm) ]] && groupadd -r nvm; \
	umask 0002; \
	usermod -aG nvm "${USERNAME}"; \
	mkdir -p "${NVM_DIR}"; \
	chgrp -R nvm "${NVM_DIR}"; \
	chmod g+s "${NVM_DIR}"

USER ${USERNAME}
RUN mkdir "/tmp/app"
WORKDIR "/tmp/app"

COPY package.json package.json
COPY install-nvm.sh install-nvm.sh
COPY activate-nvm.sh activate-nvm.sh
COPY install-app.sh install-app.sh
COPY run-app.sh run-app.sh

RUN ./install-nvm.sh
RUN ./install-app.sh

COPY . .

EXPOSE 5000

ENTRYPOINT ["/bin/bash", "-c", "./run-app.sh"]
