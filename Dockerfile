FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

RUN useradd -d /home/fledge -m fledge

WORKDIR /home/fledge


RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -qq install avahi-daemon curl cmake g++ make build-essential autoconf automake uuid-dev libtool libboost-dev libboost-system-dev libboost-thread-dev libpq-dev libssl-dev libz-dev python-dev python3-dev python3-pip python3-numpy postgresql sqlite3 libsqlite3-dev libcurl4-openssl-dev git libmodbus-dev pkg-config libasio-dev wget tar


RUN git clone https://github.com/fledge-iot/fledge.git \
    && cd fledge \
    && make -j 4\
    && make install

RUN git clone https://github.com/fledge-iot/fledge-south-modbus-c.git \
    && cd fledge-south-modbus-c \
    && mkdir build \
    && cd build \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install 
    
RUN git clone https://github.com/fledge-iot/fledge-north-http-c.git \
    && cd fledge-north-http-c \
    && mkdir build \
    && cd build \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install 
    
RUN git clone https://github.com/mz-automation/lib60870.git \
    && cd lib60870/lib60870-C \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j 4 \
    && make install 

RUN git clone https://github.com/fledge-iot/fledge-south-iec104.git \
    && cd fledge-south-iec104 \
    && mkdir build \
    && cd build \
    && export LIB_104=home/fledge/lib60870/lib60870-C \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install
     
RUN git clone https://github.com/fledge-iot/fledge-south-dnp3.git \
    && cd fledge-south-dnp3 \
    && wget https://github.com/dnp3/opendnp3/archive/refs/tags/2.4.0.tar.gz \
    && tar -xvzf 2.4.0.tar.gz \
    && cd opendnp3-2.4.0 \
    && export OPENDNP3_LIB_DIR=`pwd` \
    && mkdir build \
    && cd build \
    && cmake -DSTATICLIBS=ON .. \
    && make -j 4 \
    && make install \
    && cd ../../ \
    && mkdir build \
    && cd build \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install
    
RUN git clone https://github.com/fledge-iot/fledge-south-iec61850.git \
    && cd fledge-south-iec61850 \
    && git clone https://github.com/mz-automation/libiec61850.git \
    && cd libiec61850 \
    && export LIB_61850=`pwd` \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j 4 \
    && make install \
    && cd ../../ \
    && mkdir build \
    && cd build \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install

RUN git clone https://github.com/fledge-iot/fledge-south-http.git

RUN cp -R /home/fledge/fledge-south-http/python/fledge/plugins/south/http_south /usr/local/fledge/python/fledge/plugins/south/

RUN git clone https://github.com/fledge-iot/fledge-south-mqtt.git \
    && cd fledge-south-mqtt/python \
    && pip3 install -r requirements-mqtt-readings.txt 

RUN cp -R /home/fledge/fledge-south-mqtt/python/fledge/plugins/south/mqtt-readings /usr/local/fledge/python/fledge/plugins/south/

RUN git clone https://github.com/fledge-iot/fledge-north-azure.git \
    && cd fledge-north-azure/python \
    && pip3 install -r requirements-azure.txt

RUN cp -R /home/fledge/fledge-north-azure/python/fledge/plugins/north/azure /usr/local/fledge/python/fledge/plugins/north/
RUN git clone https://github.com/benmcollins/libjwt.git \
    && git clone https://github.com/akheron/jansson.git \
    && git clone https://github.com/eclipse/paho.mqtt.c.git \
    && cd jansson \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j 4 \
    && make install \
    && cd ../../libjwt \
    && autoreconf -i \
    && ./configure \
    && make \
    && make install \
    && cd ../paho.mqtt.c \
    && mkdir build \
    && cd build \
    && cmake -DPAHO_BUILD_DOCUMENTATION=FALSE -DPAHO_WITH_SSL=TRUE .. \
    && make \
    && make install \
    && ldconfig
RUN git clone https://github.com/fledge-iot/fledge-north-gcp.git \
    && cd fledge-north-gcp \
    && mkdir build \
    && cd build \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install

RUN git clone https://github.com/fledge-iot/fledge-north-iec104.git \
    && cd fledge-north-iec104 \
    && mkdir build \
    && cd build \
    && export LIB_104=home/fledge/lib60870/lib60870-C \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install
    
RUN git clone https://github.com/fledge-iot/fledge-service-notification.git \
    && cd fledge-service-notification \
    && mkdir build \
    && cd build \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install
    
RUN git clone https://github.com/fledge-iot/fledge-notify-setpoint.git \
    && cd fledge-notify-setpoint \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install
    
RUN git clone https://github.com/fledge-iot/fledge-notify-mqtt.git \
    && cd fledge-notify-mqtt \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install
    
RUN git clone https://github.com/fledge-iot/fledge-notify-control.git \
    && cd fledge-notify-control \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install

RUN git clone https://github.com/fledge-iot/fledge-notify-operation.git \
    && cd fledge-notify-operation \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install
    
RUN git clone https://github.com/fledge-iot/fledge-rule-average.git \
    && cd fledge-rule-average \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install

RUN git clone https://github.com/fledge-iot/fledge-rule-delta.git \
    && cd fledge-rule-delta \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install

RUN git clone https://github.com/fledge-iot/fledge-rule-watchdog.git \
    && cd fledge-rule-watchdog \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install
    
RUN git clone https://github.com/fledge-iot/fledge-rule-outofbound.git \
    && cd fledge-rule-outofbound \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install

RUN git clone https://github.com/fledge-iot/fledge-rule-simple-expression.git \
    && cd fledge-rule-simple-expression \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install

RUN git clone https://github.com/fledge-iot/fledge-service-dispatcher.git \
    && cd fledge-service-dispatcher \
    && mkdir build \
    && cd build \
    && export NOTIFICATION_SERVICE_INCLUDE_DIRS=/home/fledge/fledge-service-notification/C/services/common/include \
    && export FLEDGE_ROOT=/home/fledge/fledge \
    && cmake -DFLEDGE_INSTALL=/usr/local/fledge .. \
    && make -j 4 \
    && make install
     
EXPOSE 8081 1995 8080

CMD /bin/bash
