# syntax=docker/dockerfile:1
#################################################################
# Base image
#################################################################
FROM denoland/deno:alpine-1.43.6 as worker

# # https://gist.github.com/squarebracket/e719069522436873bc6f13efb359cac9
# RUN cp /etc/ssl/certs/ca-certificates.crt /etc/ssl/cert.pem

WORKDIR /app
COPY ./src ./src

# Extract the current commit hash and set it as a build argument
ARG COMMIT_HASH
RUN COMMIT_HASH=$(git rev-parse HEAD) 
# && \
    # echo $COMMIT_HASH > commit_hash.txt

# Set the environment variable with the commit hash
ENV COMMIT_HASH ${COMMIT_HASH}

# RUN --mount=target=. \
#   echo $(git rev-parse HEAD) > REVISION

RUN echo $REVISION
RUN deno cache --unstable src/main.ts

ENTRYPOINT ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "src/main.ts"]
