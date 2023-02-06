FROM node:16-alpine

# Install base os packages
RUN set -ex && \
    apk add --no-cache \
        bash \
        tzdata \
        iputils \
        linux-headers \
        udev

WORKDIR /usr/src/app/

# Copy app package for installing libs
COPY ./app/package.json .

# Install packages
RUN npm install

# copy all the app source code
COPY ./app/ .

# set execution to entrypoint
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]