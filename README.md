
# [sonarr-sma](https://github.com/d3fault/docker-radarr-sma)

[Radarr](https://radarr.video) is an independent fork of Sonarr reworked for automatically downloading movies via Usenet and BitTorrent.


[![radarr](https://github.com/Radarr/Radarr/blob/aphrodite/Logo/256.png)](https://radarr.video)

This containers base image is provided by: [mdhiggins/radarr-sma:preview](https://github.com/mdhiggins/radarr-sma)


## Supported Architectures

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |

## Version Tags

| Tag | Description |
| :----: | --- |
| latest | Sonarr Preview releases - latest ffmpeg snapshot |
| vaapi | Sonarr Preview releases - latest ffmpeg with vaapi HW acceleration |
| nvidia | Sonarr Preview releases - latest ffmpeg with nvidia HW acceleration |

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 8989` | The port for the Sonarr webinterface |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London, this is required for Sonarr |
| `-e UMASK_SET=022` | control permissions of files and directories created by Sonarr |
| `-v /config` | Database and sonarr configs |
| `-v /storage` | Location of TV and Downloads Library |

## Application Setup

Access the webui at `<your-ip>:7878`, for more information check out [Radarr](https://radarr.video).

# Sonarr Configuration

### Enable completed download handling
* Settings -> Download Client -> Completed Download Handling -> Enable: Yes

### Add Custom Script
* Settings -> Connect -> + Add -> custom Script

| Parameter | Value |
| --- | --- |
| On Grab | No |
| On Import | Yes |
| On Upgrade | Yes |
| On Rename | No |
| On Health Issue | No |
| Tags | leave blank |
| Path | `/usr/local/sma/postSonarr.sh` |

# SMA Information:

### Config Location
Located at `/config/sma/autoProcess.ini` inside the container

### Log Information
Located at `/config/sma/index.log` inside the container

### Hardware Acceleration

1. After container start, locate `/config/sma/autoProcess.ini`
1. Edit the `[Video]` options as specified below:
	* vaapi
		* Set video codec to: `h264vaapi` or `h265vaapi`
	* nvidia
		* Set video codec to: `h264_nvenc` or `h265_nvenc`
1. Make sure you have passed the correct device to the container, or these will not work...
