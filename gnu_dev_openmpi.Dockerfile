FROM robcking/eddy-builder-gnu:openmpi
RUN apt update
RUN apt install -y gdb &&\
    apt install -y pipx 
RUN pipx install fortls && pipx ensurepath
WORKDIR /
