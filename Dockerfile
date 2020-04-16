FROM mhart/alpine-node:11.12 AS build-env
LABEL maintainer="kai@kaidam.ltd"

RUN apk update
RUN apk upgrade
RUN apk add bash git

WORKDIR /app
COPY ./package.json /app/package.json
COPY ./yarn.lock /app/yarn.lock

RUN yarn install
COPY . /app

ARG productionMode
ARG LOGROCKET_APP
ARG LOGROCKET_ENABLE
ARG SENTRY_DSN
ARG SENTRY_ENABLE
ARG SEGMENT_KEY
ARG SEGMENT_ENABLE
ARG CRISP_ID
ARG CRISP_ENABLE
RUN if [ -n "$productionMode" ]; then yarn run build; fi

ENTRYPOINT ["yarn", "run", "develop"]

FROM nginx:alpine
LABEL maintainer="kai@kaidam.ltd"
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build-env /app/dist /www
COPY --from=build-env /app/meta.json /www