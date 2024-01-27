FROM nimlang/nim:2.0.0-alpine AS nim_with_clang
RUN apk add clang

FROM nim_with_clang AS base
WORKDIR /ci-test
COPY ci_test.nimble config.nims ./
RUN nimble -y install -d
COPY . .

FROM base AS build
ARG build_env
RUN nimble -y install -p:"-d:${build_env}"

FROM scratch
COPY --from=build /ci-test/bin /bin
