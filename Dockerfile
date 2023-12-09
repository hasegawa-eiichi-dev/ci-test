FROM nimlang/nim:2.0.0-alpine-onbuild AS nim
WORKDIR /ci-test
COPY ci_test.nimble ./
RUN nimble -y install -d

FROM nim AS builder
COPY . .
RUN nimble build -x --cc:clang --threads:on

FROM scratch
COPY --from builder /ci-test/bin /bin
