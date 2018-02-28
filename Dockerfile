FROM base/archlinux

MAINTAINER flaroche@gmail.com

# Let's run stuff
RUN \
  # First, update everything (start by keyring and pacman)
  pacman -Sy && \
  pacman -S archlinux-keyring --noconfirm && \
  pacman -S pacman --noconfirm && \
  pacman-db-upgrade && \
  pacman -Su --noconfirm && \

  # Install utilities
  pacman -S git openssh docker gcc make sed awk gzip grep curl vim tree iproute2 inetutils jdk8-openjdk sbt --noconfirm && \

  # Install zulu
  curl https://cdn.azul.com/zulu/bin/zulu8.28.0.1-jdk8.0.163-linux_x64.tar.gz --output - |tar -xzC /usr/lib/jvm && \
  ln -sf /usr/lib/jvm/zulu8.28.0.1-jdk8.0.163-linux_x64 /usr/lib/jvm/default && \
  ln -sf /usr/lib/jvm/zulu8.28.0.1-jdk8.0.163-linux_x64 /usr/lib/jvm/default-runtime && \

  # Configure sbt
  mkdir -p /root/.sbt/0.13/plugins/ && \
  echo 'addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0")' > /root/.sbt/0.13/plugins/coursier.sbt && \
  mkdir -p /root/.sbt/1.0/plugins/ && \
  echo 'addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0")' > /root/.sbt/1.0/plugins/coursier.sbt && \
  

  # Generate locale en_US (workaround for a strange bug in berkshelf)
  locale-gen en_US.UTF-8 && \

  # Time to clean
  pacman -Scc --noconfirm

ENV LANG=en_US.UTF-8
CMD ["/usr/bin/bash"]
