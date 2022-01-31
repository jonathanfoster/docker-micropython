FROM python:3.10.2-slim-bullseye

ENV MICROPYTHON_VERSION v1.18

RUN apt-get update && \
    apt-get install -y build-essential libreadline-dev libffi-dev git pkg-config gcc-arm-none-eabi libnewlib-arm-none-eabi && \
    rm -rf /var/lib/apt/lists/* && \
    git clone --depth 1 --branch $MICROPYTHON_VERSION --recurse-submodules https://github.com/micropython/micropython.git /usr/local/src/micropython && \
    cd /usr/local/src/micropython/mpy-cross && \
    make && \
    ln -s /usr/local/src/micropython/mpy-cross/mpy-cross /usr/local/bin/mpy-cross && \
    cd /usr/local/src/micropython/ports/unix && \
    make axtls && \
    make && \
    ln -s /usr/local/src/micropython/ports/unix/micropython /usr/local/bin/micropython

CMD ["micropython"]
