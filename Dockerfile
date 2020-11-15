FROM ubuntu:20.04

ENV UID=1000
ENV GID=1000
ENV USER="developer"
ENV FLUTTER_CHANNEL="beta"
ENV FLUTTER_VERSION="1.23.0-18.1.pre"
ENV FLUTTER_URL="https://storage.googleapis.com/flutter_infra/releases/$FLUTTER_CHANNEL/linux/flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz"
ENV FLUTTER_HOME="/opt/flutter"
ENV PUB_CACHE="/home/$USER/pub-cache"
ENV PATH="$FLUTTER_HOME/bin:${PATH}"

# install all dependencies
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update \
  && apt-get install --yes --no-install-recommends wget ca-certificates curl unzip sed git bash xz-utils libglvnd0 ssh xauth x11-xserver-utils libpulse0 libxcomposite1 libgl1-mesa-glx \
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
#  && apt install -y ./google-chrome-stable_current_amd64.deb \ 
  && update-ca-certificates \
  && rm -rf /var/lib/{apt,dpkg,cache,log} google-chrome-stable_current_amd64.deb
  
# create user
RUN groupadd --gid $GID $USER \
  && useradd -s /bin/bash --uid $UID --gid $GID -m $USER

RUN chown -R $USER /opt
USER $USER
RUN mkdir -p $PUB_CACHE
WORKDIR /opt

# flutter
RUN curl -o flutter.tar.xz $FLUTTER_URL \
  && mkdir -p $FLUTTER_HOME \
  && tar xf flutter.tar.xz -C /opt \
  && rm flutter.tar.xz \
  && flutter channel beta \
  && flutter config --no-analytics --enable-web \
  && flutter precache \
#   && yes "y" | flutter doctor --android-licenses \
  && flutter doctor 

COPY entrypoint.sh /usr/local/bin/
WORKDIR /project
ENTRYPOINT [ "sh", "/usr/local/bin/entrypoint.sh" ]

