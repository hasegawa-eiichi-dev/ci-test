FROM nimlang/nim:2.0.0-alpine AS doc
WORKDIR /ci-test
COPY . .
RUN nimble doc2 --project --index:on -o:docs/developer src/ci_test.nim

FROM nimlang/nim:2.0.0-alpine AS base
WORKDIR /ci-test
COPY ci_test.nimble nim.cfg ./
RUN nimble -y install -d
COPY . .

FROM base AS build
ARG nim_options=""
RUN nimble install -p "${nim_options}"

FROM scratch AS product
COPY --from=build /ci-test/bin /bin
