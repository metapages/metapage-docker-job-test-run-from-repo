set shell       := ["bash", "-c"]
set dotenv-load := true

_help:
    just --list --unsorted --list-heading $'Commands:\n'

# Build the docker image and run
run:
  docker build -t metapage/metapage-docker-job-test-run-from-repo:cache .
  docker run --rm -ti metapage/metapage-docker-job-test-run-from-repo:cache