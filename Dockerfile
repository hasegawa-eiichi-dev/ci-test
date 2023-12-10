FROM nimlang/nim:2.0.0-alpine AS prebuild
WORKDIR /ci-test
COPY ci_test.nimble nim.cfg ./
RUN nimble -y install -d
COPY . .

FROM prebuild AS test
RUN nimble test
# TODO: check advanced option: https://nim-lang.org/docs/nimc.html

FROM prebuild AS build
RUN nimble install -d:release
# nimble install --stackTrace:on --lineTrace:on --threads:on -x -a

FROM scratch AS product
COPY --from=builder /ci-test/bin /bin
