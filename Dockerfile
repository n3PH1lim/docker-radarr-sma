ARG ffmpeg_tag=4.2-vaapi
FROM jrottenberg/ffmpeg:${ffmpeg_tag} as ffmpeg
FROM mdhiggins/sonarr-sma:preview
LABEL maintainer="RandomNinjaAtk"

RUN \ 
	# remove existing ffmpeg
	rm /usr/local/bin/ffmpeg && \
	rm /usr/local/bin/ffprobe

# Add files from ffmpeg
COPY --from=ffmpeg /usr/local/ /usr/local/

RUN \
	# ffmpeg
	apt-get update -qq && \
	apt-get install -qq -y \
		libva-drm2 \
		libva2 \
		i965-va-driver \
		libgomp1 && \
	apt-get purge --auto-remove -y && \
	apt-get clean && \
	chgrp users /usr/local/bin/ffmpeg && \
	chgrp users /usr/local/bin/ffprobe && \
	chmod g+x /usr/local/bin/ffmpeg && \
	chmod g+x /usr/local/bin/ffprobe

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8989
VOLUME /config
