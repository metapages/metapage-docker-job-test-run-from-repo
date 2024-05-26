#################################################################
# Base image
#################################################################
FROM denoland/deno:alpine-1.43.6 as worker

# # https://gist.github.com/squarebracket/e719069522436873bc6f13efb359cac9
# RUN cp /etc/ssl/certs/ca-certificates.crt /etc/ssl/cert.pem

WORKDIR /app
COPY ./src ./src

RUN --mount=target=. \
  make REVISION=$(git rev-parse HEAD) build

RUN echo $REVISION
RUN deno cache --unstable src/main.ts

ENTRYPOINT ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "src/main.ts"]
