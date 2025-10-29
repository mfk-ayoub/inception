FROM debian:bullseye

WORKDIR /workspace

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-venv \
        python3-dev \
        python3-pip \
        build-essential \
        curl \
        git \
        libffi-dev \
        libssl-dev \
        libblas-dev \
        liblapack-dev \
        gfortran \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir \
        jupyter \
        numpy 
COPY src/ /workspace/srcs
WORKDIR /workspace/srcs

EXPOSE 8888

CMD ["python3", "-m", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]
