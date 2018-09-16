FROM debian:latest
RUN apt-get update
RUN apt-get install -y \
  git \
  bc \
  build-essential \
  libxkbcommon-dev \
  zlib1g-dev \
  libfreetype6-dev \
  libegl1-mesa-dev \
  libgles2-mesa-dev \
  libgbm-dev \
  libavcodec-dev \
  libsdl2-dev \
  libsdl-image1.2-dev \
  libxml2-dev \
  yasm \
  kmod

# build args 
ARG OWNER_UID
ARG OWNER_GID

# BUILD as non-root user
RUN groupadd --gid "${OWNER_GID}" "builder" 
RUN useradd --uid "${OWNER_UID}" \
  --gid "${OWNER_GID}" \
  "builder"

USER builder
