FROM nimlang/nim:2.0.0-alpine AS prebuild
WORKDIR /ci-test
COPY ci_test.nimble nim.cfg ./
RUN nimble -y install -d
COPY . .

FROM prebuild AS tester
RUN nimble build --stackTrace:on --lineTrace:on --threads:on -x -a
# TODO: check advanced option: https://nim-lang.org/docs/nimc.html
CMD nimble test

FROM prebuild AS build
RUN nimble install -d:release

FROM scratch AS product
COPY --from=builder /ci-test/bin /bin
