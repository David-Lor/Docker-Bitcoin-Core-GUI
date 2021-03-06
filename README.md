# Docker - Bitcoin Core GUI client

Run the Bitcoin Core GUI wallet on a Docker container, accesible via web browser and VNC.
Built over the [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui) image (debian-9 version).

**This image is experimental and might have undesirable effects. Use it under your responsability!**

## Getting started

```bash
docker volume create --name=bitcoin-data
docker run -d --name=bitcoin-core-gui -p 5800:5800 -v bitcoin-data:/config davidlor/bitcoin-core-gui
```

Open your browser and go to `localhost:5800`. You should see the Bitcoin Core GUI application running!

**On the first run, the Welcome window will open, where you will be prompted for the data location.
You should set it to somewhere inside `/config`** (by default, is set to `/config/.bitcoin`)

## Volume (persistence)

The Bitcoin Core data directory is set to `/config/.bitcoin` by default. A volume is created for `/config`,
but you might want to mount the `/config/.bitcoin` directory on other volume or a bind mount.

You can even mount sub-directories of the Bitcoin data directory. These are the most important::
- `/config/.bitcoin/blocks` for the blockchain
- `/config/.bitcoin/wallet.dat` for your wallet
- `/config/.bitcoin/bitcoin.conf` for the client configuration
- `/config/xdg/config/Bitcoin/Bitcoin-Qt.conf` for the frontend (bitcoin-qt) configuration

_The `/config` directory is used by the [base image for persisting settings](https://github.com/jlesage/docker-baseimage-gui#config-directory)
of the image tools and the application running. We set it as the HOME directory, so this results in bitcoin-qt
setting the data directory to `/config/.bitcoin` by default._

## Other settings

Please refer to the [documentation of the base image](https://github.com/jlesage/docker-baseimage-gui) for
VNC/webui related settings, such as securing the connection and so on.

## Changelog

- 0.3.1 - Revert "compile" in Dockerfile (since the compiled official releases already included ZeroMQ).
          The "compiled version" is kept on the [feature/compile branch](https://github.com/David-Lor/Docker-Bitcoin-Core-GUI/tree/feature/compile).
- 0.2.1 - Compile Bitcoin Core QT on Dockerfile, adding support for ZeroMQ. Add volume in Dockerfile.
- 0.1.1 - Add Bitcoin logo as container favicon
- 0.0.1 - Initial release

## TODO

- Automate getting the latest Bitcoin Core version,
- Download Bitcoin Core from torrent (using aria2) for faster download speed - or other alternative repository?
- SquashFS + OverlayFS support for blockchain compression
- Multi-arch support
- ~~Do not ask for data location on first client start~~ (0.2.1): now we set the HOME directory to /config, so the default
  data dir is `/config/.bitcoin`. Is better to keep the Welcome window for the first time the container + volume start.
