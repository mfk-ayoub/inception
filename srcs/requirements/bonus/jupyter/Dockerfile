FROM debian:bullseye

WORKDIR /workspace/srcs

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        wget \
        curl \
        git \
        libffi-dev \
        libssl-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        libncurses5-dev \
        libncursesw5-dev \
        zlib1g-dev \
        liblzma-dev \
        tk-dev \
        libgdbm-dev \
        libnss3-dev \
        libgdbm-compat-dev \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://www.python.org/ftp/python/3.7.17/Python-3.7.17.tgz && \
    tar xvf Python-3.7.17.tgz && \
    cd Python-3.7.17 && \
    ./configure && \
    make -j2 && \
    make altinstall && \
    cd .. && rm -rf Python-3.7.17 Python-3.7.17.tgz


RUN python3.7 -m ensurepip
RUN python3.7 -m pip install --no-cache-dir --upgrade pip
RUN python3.7 -m pip install --no-cache-dir \
        jupyter \
        numpy \
        ipywidgets \
        turicreate

COPY src/ /workspace/srcs

EXPOSE 8888

CMD ["python3.7", "-m", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
