FROM base/archlinux

MAINTAINER flaroche@gmail.com

RUN pacman -Sy && \
  pacman -S archlinux-keyring --noconfirm && \
  pacman -S pacman --noconfirm && \
  pacman-db-upgrade && \
  pacman -Su --noconfirm && \
  pacman -S git openssh docker gcc make sed awk gzip grep curl vim tree iproute2 inetutils jdk10-openjdk sbt jq --noconfirm --needed && \
  mkdir -p /root/.sbt/0.13/plugins/ && \
  echo 'addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0")' > /root/.sbt/0.13/plugins/coursier.sbt && \
  mkdir -p /root/.sbt/1.0/plugins/ && \
  echo 'addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0")' > /root/.sbt/1.0/plugins/coursier.sbt && \
  locale-gen en_US.UTF-8 && \
  pacman -Scc --noconfirm

ENV LANG=en_US.UTF-8
CMD ["/usr/bin/bash"]
