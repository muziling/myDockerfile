# FROM --platform=linux/amd64 ubuntu/dotnet-runtime:edge as build1
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/runtime:8.0-jammy as build1
ARG TARGETARCH
RUN apt-get install -y coreutils

COPY --chmod=755 ./N_m3u8DL-RE_Beta_linux-x64/N_m3u8DL-RE /app/m3u8dl
COPY --chmod=755 ./ffmpeg-master-latest-linux64-gpl/bin/ffmpeg /app/ffmpeg
COPY --chmod=755 ./packager-linux-x64 /app/shaka-packager
COPY --chmod=755 ./Bento4-SDK-1-6-0-641.x86_64-unknown-linux/bin/mp4decrypt /app/mp4decrypt
COPY --chmod=755 ./m3u8 /app/m3u8

COPY --chmod=755 ./N_m3u8DL-RE_Beta_linux-arm64/N_m3u8DL-RE /app/m3u8dl_
COPY --chmod=755 ./ffmpeg-master-latest-linuxarm64-gpl/bin/ffmpeg /app/ffmpeg_
COPY --chmod=755 ./packager-linux-arm64 /app/shaka-packager_
COPY --chmod=755 ./m3u8-linux-arm64 /app/m3u8_


RUN if [ "$TARGETARCH" = "amd64" ]; then \
  rm -f /app/*_; \
fi

RUN if [ "$TARGETARCH" = "arm64" ]; then \
  mv /app/m3u8dl_ /app/m3u8dl && \
  mv /app/ffmpeg_ /app/ffmpeg && \
  mv /app/shaka-packager_ /app/shaka-packager && \
  mv /app/m3u8_ /app/m3u8 && \
  rm -f /app/mp4decrypt; \
fi

FROM scratch
COPY --from=build1 / /

ENV PATH="${PATH}:/app"

EXPOSE 8080

CMD ["/app/m3u8", "-cache-dir", "/tmp/cache", "-channel-file", "/app/channels.json"]
