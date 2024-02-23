# FROM --platform=linux/amd64 ubuntu/dotnet-runtime:edge as build1
FROM --platform=linux/amd64 mcr.microsoft.com/dotnet/runtime:8.0-jammy as build1
RUN apt-get install coreutils

COPY --chmod=755 ./N_m3u8DL-RE_Beta_linux-x64/N_m3u8DL-RE /app/m3u8dl
COPY --chmod=755 ./ffmpeg-master-latest-linux64-gpl/bin/ffmpeg /app/ffmpeg
COPY --chmod=755 ./packager-linux-x64 /app/shaka-packager
COPY --chmod=755 ./Bento4-SDK-1-6-0-641.x86_64-unknown-linux/bin/mp4decrypt /app/mp4decrypt
COPY --chmod=755 ./m3u8 /app/m3u8

FROM scratch
COPY --from=build1 / /

ENV PATH="${PATH}:/app"

EXPOSE 8080

CMD ["/app/m3u8", "-cache-dir", "/tmp/cache", "-channel-file", "/app/channels.json"]
