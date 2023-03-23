sudo apt install -y \
    apt-file \
    neovim \
    git \
    build-essential \
    cmake \
    clang \
    clang-format-11 \
    libclang-11-dev \
    zlib1g-dev \
    libpcap-dev \
    libnuma-dev \
    libconfig++-dev \
    ninja-build \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    virtualenv \
    libspdlog-dev \
    doxygen \
    dnsutils \
    man \
    gdb \
    bear \
    netcat \
    tcpdump \
    net-tools \
    dh-make \
    rsync \
    libsystemd-dev \
    ragel \
    libyaml-cpp-dev \
    bc \
    lcov \
    gcovr \
    libibverbs1 \
    libibverbs-dev \
    libtbb-dev \
    protobuf-compiler

pip3 install --upgrade meson
pip3 install pyelftools
