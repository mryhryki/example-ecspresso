FROM denoland/deno:1.21.1
COPY ./index.ts ./version.ts ./

EXPOSE 80
RUN deno cache ./index.ts

CMD ["run", "--allow-net", "./index.ts"]
