FROM robcking/eddy-builder-gnu:latest
RUN apt update
RUN apt install -y gdb &&\
    apt install -y pipx &&\
    apt install -y cmake 
RUN pipx install fortls && pipx ensurepath
WORKDIR /
