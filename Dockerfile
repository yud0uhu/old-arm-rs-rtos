FROM debian:latest

RUN apt-get update && apt-get -y install \
    curl \
    usbutils \
    libusb-dev \
    sudo

RUN apt-get update && apt-get -y install \
    binutils-arm-none-eabi \
    gdb-arm-none-eabi \
    openocd \
    cmake \
    libssl-dev \
    libssh-dev \
    pkg-config \
    git \
    && ln -s /usr/bin/gdb-multiarch /usr/bin/arm-none-eabi-gdb

USER root

ENV RUST_HOME /usr/local/lib/rust
ENV RUSTUP_HOME ${RUST_HOME}/rustup
ENV CARGO_HOME ${RUST_HOME}/cargo
RUN mkdir /usr/local/lib/rust && \
    chmod 0755 $RUST_HOME # 0755 rwxr-xr-x
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > ${RUST_HOME}/rustup.sh \
    && chmod +x ${RUST_HOME}/rustup.sh \
    && ${RUST_HOME}/rustup.sh -y --default-toolchain nightly --no-modify-path
ENV PATH $PATH:$CARGO_HOME/bin

RUN cargo install cargo-clone cargo-edit xargo

WORKDIR /work/cortex-m-rs

RUN cargo clone cortex-m-quickstart \
    && mv cortex-m-quickstart cortex-m-rs-template && cd $_

RUN rustup component add rust-src \
    && rustup update && rustup default nightly \
    && rustup target add thumbv7em-none-eabihf

USER user