# syntax=docker/dockerfile:1


# Stage 1: Extract the commit hash
FROM denoland/deno:alpine-1.43.6 AS git-info
WORKDIR /repo

# Install git to read the commit hash
RUN apk add --no-cache git

# Copy the .git directory to the temporary stage
COPY .git .

# Extract the commit hash
RUN COMMIT_HASH=$(git rev-parse HEAD) && echo $COMMIT_HASH > /commit_hash.txt

# Stage 2: Build the final Deno image
FROM denoland/deno:latest
WORKDIR /app




#################################################################
# Base image
#################################################################
FROM denoland/deno:alpine-1.43.6 as worker

# Copy the commit hash from the previous stage
COPY --from=git-info /commit_hash.txt /app/commit_hash.txt

# # https://gist.github.com/squarebracket/e719069522436873bc6f13efb359cac9
# RUN cp /etc/ssl/certs/ca-certificates.crt /etc/ssl/cert.pem

RUN exit 1

WORKDIR /app
COPY ./src ./src

# Extract the current commit hash and set it as a build argument
# ARG COMMIT_HASH
# RUN COMMIT_HASH=$(git rev-parse HEAD) 
# # && \
#     # echo $COMMIT_HASH > commit_hash.txt

# # Set the environment variable with the commit hash
# ENV COMMIT_HASH ${COMMIT_HASH}

# RUN --mount=target=. \
#   echo $(git rev-parse HEAD) > REVISION

# RUN echo $REVISION
RUN deno cache --unstable src/main.ts

ENTRYPOINT ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "src/main.ts"]
