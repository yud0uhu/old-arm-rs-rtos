FROM archlinux:latest

# The tools Install

RUN pacman -Syu --noconfirm \
    sudo \
    curl \
    usbutils \
    arm-none-eabi-gdb \
    qemu-arch-extra \
    openocd

ENV RUST_HOME /usr/local/lib/rust
ENV RUSTUP_HOME ${RUST_HOME}/rustup
ENV CARGO_HOME ${RUST_HOME}/cargo
RUN mkdir /usr/local/lib/rust && \
    chmod 0755 $RUST_HOME # 0755 rwxr-xr-x
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > ${RUST_HOME}/rustup.sh \
    && chmod +x ${RUST_HOME}/rustup.sh \
    && ${RUST_HOME}/rustup.sh -y --default-toolchain nightly --no-modify-path
ENV PATH $PATH:$CARGO_HOME/bin

RUN /bin/sh -c cargo install cargo-edit \
    xargo

RUN rustup component add rust-src \
    && rustup update && rustup default nightly \
    && rustup target add thumbv7em-none-eabihf

WORKDIR /work/cortex-m-rs

ENTRYPOINT ["/bin/sh","-c"]

# The Cargo project template

# cargo install cargo-clone \
# cargo clone cortex-m-quickstart \
# mv cortex-m-quickstart cortex-m-rs-template && cd $_