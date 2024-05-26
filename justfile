set shell       := ["bash", "-c"]
set dotenv-load := true

_help:
    just --list --unsorted --list-heading $'Commands:\n'

# Build the docker image from the remote repository
build:
  docker build --build-arg BUILDKIT_CONTEXT_KEEP_GIT_DIR=1 -t metapage/metapage-docker-job-test-run-from-repo:cache https://github.com/metapages/metapage-docker-job-test-run-from-repo.git

# Build the docker image and run
build-and-run: build
  docker run --rm -ti metapage/metapage-docker-job-test-run-from-repo:cache

# For faster iterative development
commit-push-build-and-run:
  git add .
  git commit -m "Update"
  git push
  just build-and-run