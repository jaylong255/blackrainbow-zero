# Set host user and group id for all stages
ARG HOST_USER_UID=1001
ARG HOST_USER_GID=1001

FROM node:16.15.1-alpine3.14 AS npm

ARG HOST_USER_UID
ARG HOST_USER_GID

# Add the user that will be expected, sharing a user and group id with the host
RUN addgroup --gid ${HOST_USER_GID} nginx
RUN adduser --system --no-create-home --uid $HOST_USER_UID --ingroup nginx webuser

# Copy the application files
WORKDIR /app
COPY --chown=webuser:nginx ./. /app/

# Install the required dependencies for composer and laravel
RUN apk add --no-cache --virtual .build-deps \
    g++ \
    gcc \
    git \
    make \
    python3 \
    && npm install \
    && apk del .build-deps