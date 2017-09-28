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

  # Install Git
  pacman -S git --noconfirm && \

  # Install Docker
  pacman -S docker --noconfirm && \

  # Install what is needed for building native extensions
  pacman -S gcc make sed awk gzip grep --noconfirm && \

  # Install useful tools
  pacman -S vim tree iproute2 inetutils --noconfirm && \

  # Install sbt
  pacman -S jdk8-openjdk sbt --noconfirm && \

  # Configure sbt
  mkdir -p /root/.sbt/0.13/plugins/ && \
  echo 'addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-RC11")' > /root/.sbt/0.13/plugins/coursier.sbt && \
  mkdir -p /root/.sbt/1.0/plugins/ && \
  echo 'addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-RC11")' > /root/.sbt/1.0/plugins/coursier.sbt && \
  

  # Generate locale en_US (workaround for a strange bug in berkshelf)
  locale-gen en_US.UTF-8 && \

  # Time to clean
  pacman -Scc --noconfirm

ENV LANG=en_US.UTF-8
CMD ["/usr/bin/bash"]
