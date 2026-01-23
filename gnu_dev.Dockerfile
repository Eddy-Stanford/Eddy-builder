FROM robcking/eddy_builder:gnu_mpich
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
RUN apt install -y gdb &&\
    apt install -y pipx 
RUN pipx install fortls && pipx ensurepath
RUN useradd -ms /bin/bash eddy
USER eddy
WORKDIR /home/eddy
