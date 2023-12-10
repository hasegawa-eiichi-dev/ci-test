FROM nimlang/nim:2.0.0-alpine AS base
WORKDIR /ci-test
COPY ci_test.nimble nim.cfg ./
RUN nimble -y install -d
COPY . .

FROM base AS build
RUN nimble install -d:release
# nimble install --stackTrace:on --lineTrace:on --threads:on -x -a
# TODO: check advanced option: https://nim-lang.org/docs/nimc.html

FROM scratch AS product
COPY --from=build /ci-test/bin /bin
