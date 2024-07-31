FROM eddy-builder-gnu
RUN apt update
RUN apt install -y gdb &&\
    apt install -y pipx
RUN pipx install fortls && pipx ensurepath
WORKDIR /
