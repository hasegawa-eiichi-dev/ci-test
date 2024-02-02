# syntax=docker/dockerfile:1
ARG BUILDKIT_SBOM_SCAN_CONTEXT=true
ARG BUILDKIT_SBOM_SCAN_STAGE=true

FROM nimlang/nim:2.0.2-alpine AS nim_with_clang
RUN apk add clang
ADD https://github.com/coord-e/magicpak/releases/download/v1.4.0/magicpak-x86_64-unknown-linux-musl /usr/bin/magicpak
RUN chmod +x /usr/bin/magicpak

FROM nim_with_clang AS base
WORKDIR /ci-test
COPY ci_test.nimble config.nims ./
RUN nimble -y install -d
COPY . .

FROM base AS build
ARG build_env
RUN nimble -y install -p:"-d:${build_env}"
RUN /usr/bin/magicpak -v -r=bin/ci_test /ci-test/bin/ci_test /bundle

FROM scratch
COPY --from=build /bundle /.
ENTRYPOINT ["/bin/ci_test"]
