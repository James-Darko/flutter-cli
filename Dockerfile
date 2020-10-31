FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install curl unzip git -y
RUN git clone https://github.com/flutter/flutter.git -b beta --depth 1
RUN mv flutter /opt/flutter
ENV PATH="/opt/flutter/bin:${PATH}"
RUN flutter config --enable-web
RUN flutter build web > /dev/null 2>&1 || true
WORKDIR /project
ENTRYPOINT ["flutter"]
CMD ["--version"]
