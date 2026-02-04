FROM ubuntu:jammy
WORKDIR /opt
RUN apt-get -yqq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install build-essential libtool git
RUN apt-get -yqq install gcc-12 g++-12 gfortran-12
RUN ln -s -f /usr/bin/gcc-12 /usr/bin/gcc
RUN ln -s -f /usr/bin/g++-12 /usr/bin/g++
RUN ln -s -f /usr/bin/gfortran-12 /usr/bin/gfortran
RUN apt-get -yqq install cmake
RUN apt-get -yqq install openmpi-bin libopenmpi-dev openmpi-common
RUN apt-get -yqq install libnetcdf-mpi-dev libnetcdff-dev libhdf5-openmpi-dev
RUN apt-get -yqq install libopenblas64-dev
RUN apt-get -yqq install libudunits2-0 libudunits2-dev libudunits2-data
RUN apt-get -yqq install libyaml-dev
RUN apt-get -yqq install python3-dev
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata
ENV FC=gfortran
ENV CC=gcc

# ## LOAD SPACK
# RUN git clone -c feature.manyFiles=true --depth=2 https://github.com/spack/spack.git
# RUN . spack/share/spack/setup-env.sh
# ENV PATH=/opt/spack/bin:$PATH
## INSTALL OPENMPI
# RUN spack mirror add develop https://binaries.spack.io/develop
# RUN spack buildcache keys --install --trust
# RUN spack install gcc@12 
# RUN spack compiler add $(spack location -i gcc@12)
# RUN spack install openmpi%gcc@12 fabrics=ucx
# RUN spack install netcdf-fortran%gcc@12 ^netcdf-c%gcc@12 ^hdf5+fortran%gcc@12
# RUN spack install openblas%gcc@12
# RUN spack install udunits%gcc@12
# RUN . /opt/spack/share/spack/setup-env.sh
WORKDIR /