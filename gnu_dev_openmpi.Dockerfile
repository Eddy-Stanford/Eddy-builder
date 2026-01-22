FROM robcking/eddy_builder:gnu_openmpi

RUN apt update
RUN apt install -yqq gdb &&\
    apt install -yqq pipx 
RUN useradd -ms /bin/bash eddy
USER eddy
RUN pipx install fortls && pipx ensurepath
WORKDIR /home/eddy
