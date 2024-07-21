#!/usr/bin/env bash

# Script to setup an android build environment for openSUSE.

# openSUSE Mirrors (https://github.com/Firstyear/mirrorsorcerer)
sudo zypper install -y mirrorsorcerer
sudo systemctl enable --now mirrorsorcerer

# Packages
sudo zypper install \
    android-tools \
    autoconf213 \
    bc \
    bison \
    bzip2 \
    ccache \
    clang \
    curl \
    flex \
    gawk \
    gpg2 \
    gperf \
    gcc-c++ \
    git \
    git-lfs \
    glibc-devel \
    ImageMagick \
    java-11-openjdk \
    java-1_8_0-openjdk \
    java-1_8_0-openjdk-devel \
    liblz4-1 \
    libncurses5 \
    libpopt0 \
    libressl-devel \
    libstdc++6\
    libxml2-tools \
    libxslt1 \
    lzip \
    lzop \
    kernel-devel \
    maven \
    make \
    megatools \
    Mesa-libGL1 \
    Mesa-libGL-devel \
    mokutil \
    ncurses5-devel \
    ncurses-devel \
    openssl \
    opi \
    patch \
    perl-Digest-SHA1 \
    python \
    python-rpm-generators \
    readline-devel \
    schedtool \
    sha3sum \
    squashfs \
    wget \
    zip \
    zlib-devel

# Suggested
# sudo zypper install -y android-tools-mkbootimg android-tools-partition clang-doc

# Devel Basis on OpenSUSE (https://darryldias.me/2020/devel-basis-on-opensuse-sle/)
sudo zypper install -t pattern devel_basis

# Repo
echo "Installing Git Repository Tool"
sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
sudo chmod a+rx /usr/local/bin/repo

echo -e "Setting up udev rules for ADB!"
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules
sudo chown root /etc/udev/rules.d/51-android.rules
sudo udevadm control --reload-rules