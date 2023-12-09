FROM nimlang/nim:2.0.0-alpine-onbuild AS nim
WORKDIR /ci-test
COPY ci_test.nimble ./
RUN apt-get install --no-install-recommends clang
RUN echo $PATH
RUN whereis nimble
RUN nimble -y install -d

FROM nim AS builder
RUN ls -a
COPY . .
RUN ls -a
RUN echo $PATH
RUN whereis nimble
RUN nimble build -x --cc:clang --threads:on

FROM scratch
COPY --from=builder /ci-test/bin /bin
