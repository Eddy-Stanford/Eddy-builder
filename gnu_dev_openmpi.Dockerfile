FROM robcking/eddy_builder:gnu_openmpi

RUN apt update
RUN apt install -yqq gdb &&\
    apt install -yqq pipx && \
    apt install -yqq sudo
RUN useradd -ms /bin/bash eddy
RUN passwd -d eddy
RUN echo "eddy ALL=(ALL:ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/eddy
USER eddy
RUN pipx install fortls && pipx ensurepath
WORKDIR /home/eddy
