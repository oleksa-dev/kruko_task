ARG BUILD_ENV=development

FROM surnet/alpine-wkhtmltopdf:3.9-0.12.5-full as wkhtmltopdf
FROM ruby:3.1.2-alpine3.16 as rubyonrails

ARG BUILD_ENV

ENV RAILS_ENV=$BUILD_ENV

RUN echo Building for *** $BUILD_ENV *** environment

ENV APP_ROOT /src

RUN mkdir ${APP_ROOT}
WORKDIR ${APP_ROOT}

RUN apk update && apk add --no-cache \
    libstdc++ \
    libx11 \
    libxrender \
    libxext \
    libssl1.1 \
    ca-certificates \
    fontconfig \
    freetype \
    ttf-dejavu \
    ttf-droid \
    ttf-freefont \
    build-base g++ gcc libgcc python3 \
    postgresql postgresql-contrib libpq-dev \
    git nano bash mc \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

COPY --from=wkhtmltopdf /bin/wkhtmltopdf /bin/wkhtmltopdf

RUN chmod +x /bin/wkhtmltopdf

RUN gem update --system

COPY Gemfile Gemfile.lock ./

RUN gem install bundler --no-document \
    && bundle install \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete

EXPOSE 3000

CMD rm -f "${APP_ROOT}/tmp/pids/server.pid" && bundle exec rails s -p 3000 -b 0.0.0.0
