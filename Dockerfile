FROM intel/oneapi-hpckit
WORKDIR /opt
RUN apt-get -yqq update
RUN apt-get -yqq upgrade
RUN apt-get -yqq install git && \
    apt-get -yqq install make && \
    apt-get -yqq install wget && \
    apt-get -yqq install m4 && \
    apt-get -yqq install zlib1g-dev && \
    apt-get -yqq install autoconf && \
    apt-get -yqq install automake && \
    apt-get -yqq install libtool && \
    apt-get -yqq install autogen && \
    apt-get -yqq install intltool && \
    apt-get -yqq install libpmi2-0-dev
ENV FC=ifort
ENV CC=icx
ENV hdf5="hdf5-1.12.0"  
ENV I_MPI_PMI_LIBRARY=/usr/lib/x86_64-linux-gnu/libpmi2.so
RUN  wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/${hdf5}/src/${hdf5}.tar.gz && \
    tar xzf  ${hdf5}.tar.gz
WORKDIR /opt/${hdf5}
RUN ./configure FC=ifort CC=icx LDFLAGS='-lz' --prefix=/opt/hdf5 --enable-fortran && \
    make install 
WORKDIR /opt
RUN rm ${hdf5}.tar.gz && rm -rf ${hdf5}
ENV HDF5_INC=/opt/hdf5/include
ENV HDF5_LIB=/opt/hdf5/lib
ENV LD_LIBRARY_PATH=/opt/hdf5/lib:${LD_LIBRARY_PATH}

ENV netcdfc="netcdf-c-4.7.4"
RUN  wget -O ${netcdfc}.tar.gz https://github.com/Unidata/netcdf-c/archive/v4.7.4.tar.gz && \
    tar xzf ${netcdfc}.tar.gz 

WORKDIR /opt/${netcdfc}
RUN  ./configure --prefix=/opt/netcdf-c CPPFLAGS='-I/opt/hdf5/include -I${IO_LIBS}/include' LDFLAGS='-L/opt/hdf5/lib -L/opt/io_libs/lib -lz' --disable-dap && \
    make && \
    make install 

ENV LD_LIBRARY_PATH=/opt/netcdf-c/lib:${LD_LIBRARY_PATH}
ENV PATH=/opt/netcdf-c/bin:${PATH}
ENV NETCDF_INC=/opt/netcdf-c/include
ENV NETCDF_LIB=/opy/netcdf-c/lib
WORKDIR /opt
RUN rm ${netcdfc}.tar.gz && rm -rf ${netcdfc}
ENV netcdff="netcdf-fortran-4.5.3"
RUN wget -O ${netcdff}.tar.gz https://github.com/Unidata/netcdf-fortran/archive/v4.5.3.tar.gz && \
    tar xzf ${netcdff}.tar.gz 
WORKDIR /opt/${netcdff}
RUN ./configure CPPFLAGS="-I/opt/netcdf-c/include -I/opt/hdf5/include/" LDFLAGS="-L/opt/netcdf-c/lib -lnetcdf" --prefix=/opt/netcdf-fortran && \
    make && \
    make -j20 install
ENV PATH=/opt/netcdf-fortran/bin:${PATH}
ENV LD_LIBRARY_PATH=/opt/netcdf-c/lib:/opt/hdf5/lib:/opt/netcdf-fortran/lib:${LD_LIBRARY_PATH}
ENV LIBRARY_PATH=${LD_LIBRARY_PATH}
ENV NETCDF_FORTRAN_INC=/opt/netcdf-fortran/include
ENV NETCDF_FORTRAN_LIB=/opt/netcdf-fortran/lib 
WORKDIR /opt
RUN rm ${netcdff}.tar.gz && rm -rf ${netcdff}

RUN wget -O udunits-2.2.28.tar.gz https://downloads.unidata.ucar.edu/udunits/2.2.28/udunits-2.2.28.tar.gz && \
    tar xzf udunits-2.2.28.tar.gz 
WORKDIR /opt/udunits-2.2.28

RUN apt-get install -yqq libexpat1-dev
RUN ./configure CPPFLAGS="-I/opt/netcdf-c/include -I/opt/hdf5/include/ -I/opt/netcdf-fortran/include" LDFLAGS="-L/opt/netcdf-c/lib -lnetcdf -L/opt/netcdf-fortran/lib -lnetcdff"  --prefix=/opt/udunits && \
    make && \
    make install 
WORKDIR /