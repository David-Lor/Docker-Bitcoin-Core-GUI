# # # Stage 1 # # #
# Download bitcoin-core

FROM jlesage/baseimage-gui:debian-9 as download
ARG DOWNLOAD_URL="https://bitcoin.org/bin/bitcoin-core-0.19.1/bitcoin-0.19.1-x86_64-linux-gnu.tar.gz"

RUN apt-get -yq update && apt-get -yq install curl

WORKDIR /
RUN curl "${DOWNLOAD_URL}" --output "bitcoin-core.tar.gz"
RUN tar -xzf "bitcoin-core.tar.gz"

# # # Stage 2 # # #
# Setup the final image

FROM jlesage/baseimage-gui:debian-9
ARG APP_ICON="https://bitcoin.org/img/icons/opengraph.png"
ENV APP_NAME="BitcoinCoreGUI"

RUN install_app_icon.sh "${APP_ICON}"

COPY --from=download /bitcoin-*/bin/bitcoin-qt /usr/local/bin/
RUN chmod +x /usr/local/bin/bitcoin-qt

COPY startapp.sh /startapp.sh
VOLUME /config
