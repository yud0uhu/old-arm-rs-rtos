FROM archlinux:latest

# The tools Install

RUN pacman -Syu --noconfirm \
    sudo \
    curl \
    usbutils \
    arm-none-eabi-gdb \
    qemu-arch-extra \
    openocd

USER root

ENV RUST_HOME=/usr/local/lib/rust \
    RUSTUP_HOME=${RUST_HOME}/rustup \
    CARGO_HOME=${RUST_HOME}/cargo

RUN mkdir /usr/local/lib/rust && \
    chmod 0755 $RUST_HOME # 0755 rwxr-xr-x

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > ${RUST_HOME}/rustup.sh \
    && chmod +x ${RUST_HOME}/rustup.sh \
    && ${RUST_HOME}/rustup.sh -y --default-toolchain nightly --no-modify-path

ENV PATH $PATH:$CARGO_HOME/bin

RUN /bin/sh -c cargo install cargo-edit \
    xargo \
    && rustup component add rust-src \
    && rustup update && rustup default nightly \
    && rustup target add thumbv7em-none-eabihf

WORKDIR /work/cortex-m-rs

# The Cargo project template

# cargo install cargo-clone \
# cargo clone cortex-m-quickstart \
# mv cortex-m-quickstart cortex-m-rs-template && cd $_

# make docker image
# docker build -t cortex-m-rs --platform linux/amd64 .

# run docker container
# docker run --rm -it --platform linux/amd64 cortex-m-rs:latest