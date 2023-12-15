FROM nimlang/nim:2.0.0-alpine AS base
WORKDIR /ci-test
COPY ci_test.nimble nim.cfg ./
RUN nimble -y install -d
COPY . .

FROM base AS build
ARG nim_options=""
RUN nimble install -p "${nim_options}"
# nimble install --stackTrace:on --lineTrace:on --threads:on -x -a
# TODO: check advanced option: https://nim-lang.org/docs/nimc.html
# https://hl4.gitee.io/nim/nimc.html

FROM scratch AS product
COPY --from=build /ci-test/bin /bin
