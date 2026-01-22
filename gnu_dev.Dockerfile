FROM robcking/eddy_builder:gnu_mpich
RUN apt update
RUN apt install -y gdb &&\
    apt install -y pipx 
RUN pipx install fortls && pipx ensurepath
RUN useradd -ms /bin/bash eddy
USER eddy
RUN . /opt/spack/share/spack/setup-env.sh
WORKDIR /home/eddy
