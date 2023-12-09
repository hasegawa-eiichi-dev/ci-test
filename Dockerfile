FROM nimlang/nim:2.0.0-alpine-onbuild AS base
WORKDIR /ci-test
COPY ci_test.nimble ./
RUN apk add clang
RUN nimble -y install -d

FROM base AS builder
COPY . .
RUN nimble build -x --threads:on

FROM scratch
COPY --from=builder /ci-test/bin /bin
