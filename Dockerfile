# Container image that runs your code
FROM alpine:3.10

LABEL "com.github.actions.name"="Assign to One Project"
LABEL "com.github.actions.description"="Assign new Issue or Pull Request to default project dashboard column"
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/srggrs/assign-one-project-github-action"
LABEL "homepage"="https://github.com/srggrs/assign-one-project-github-action"
LABEL "maintainer"="srggrs"

RUN apk add --no-cache --no-progress curl jq

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
