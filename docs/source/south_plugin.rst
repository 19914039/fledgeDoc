South Plugin
======

Fledge has various south plugins that can be used to acquire data from various south sensors or devices. It supports most of the common industrial communication protocols. In this section we will look at how to install the required south plugins from source code. Fledge plugins avaiable may have been implemented using c/c++ or python. Here we will first look at the installation of plugins written in c/c++ and then later we will explore installation of plugins written in python.

.. note::

  Some of the fledge plugins will only support installation mode from the source code and not from repository

Before proceeding to install south plugins, make sure that you have already installed fledge. If not refer to fledge installation section. And further while installing any of the fledge plugins it's better to stop the fledge first and then proceed for the installtion. Once the installtion is over you can restart the fledge to get changes effect and continue to use.

Fledge-south-iec-104
-------

This is the plugin used for communicating with the south field devices that supports IEC-60870-5-104. The field device will act as a server and the fledge will act as client.


.. note::

  ``It is also required to have Fledge installed from the source code, not from the package repository.`` 

It has library dependency on IEC-60870, so first clone to this library repository using the link https://github.com/mz-automation/lib60870 and then install it as below

.. code-block:: console

  cd fledge-src
  git clone https://github.com/mz-automation/lib60870.git
  cd lib60870/lib60870-C
  mkdir build
  cd build
  cmake ..
  make -j 4
  sudo make install
  cd
  
after successful installtion you can verify the library installation by visiting the directory */usr/local/lib/*, you should see the 60870 related .so files. Now we can proceed for installing south plugin 104 for fledge. for this first clone to the source code and then install by follwing as given below
  
.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-iec104.git
  cd fledge-south-iec104
  mkdir build
  cd build
  export LIB_104=~/fledge-src/lib60870/lib60870-C
  export FLEDGE_ROOT=~/fledge-src/fledge
  cmake -DFLEDGE_INSTALL=/usr/local/fledge ..
  make -j 4
  sudo make install
  cd
  
  
Fledge-south-modbus-c
-------

It has library dependency on Modbus Library, libmodbus, use the bellow command to install the same

.. code-block:: console

  sudo apt-get install -y libmodbus-dev
  
Now we can proceed for installing south plugin Modbus for fledge. for this first clone to the source code and then install by follwing as given below
  
.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-modbus-c.git
  cd fledge-south-modbus-c
  mkdir build
  cd build
  export FLEDGE_ROOT=~/fledge-src/fledge
  cmake -DFLEDGE_INSTALL=/usr/local/fledge ..
  make -j 4
  sudo make install
  cd

This plugin also supports ``float`` data reading form modbus server/slave. for this we need to do the following modification.

.. code:: console

  "type":"float",
  "register":[1,2]
  
an Example configuration can be found here https://github.com/19914039/fledge-raspi/blob/main/microGrid-Read-Fledge.txt

Fledge-south-dnp3
-------

.. note::

  ``It is also required to have Fledge installed from the source code, not from the package repository.`` 

It has library dependency on opendnp3, and again the library has a dependency on libboost and libasio. Install all the dependencies as below

.. code-block:: console

  sudo apt-get install libboost-dev
  sudo apt-get install libasio-dev
  cd fledge-src
  git clone --recursive -b release-2.x https://github.com/dnp3/opendnp3.git
  cd opendnp3-2.4.0
  mkdir build
  cd build
  cmake -DSTATICLIBS=ON ..
  make -j 4
  sudo make install
  cd

.. note::

In case if the git clone fails to download the opendnp3 2.x version, then follow the given procedure

- Visit the opendnp3 github repository at the link https://github.com/dnp3/opendnp3
- On the right side, look for Releases section and click on +33 releases
- Look for the version 2.4.0, under this click on Assets
- Click on Source code tar.gz to download the same
- Then extract and install using the below commands

.. code-block:: console

  cd ~/Downloads
  tar -xvzf opendnp3-2.4.0.tar.gz
  cp -r opendnp3-2.4.0 ~/fledge-src
  cd ~/fledge-src
  cd opendnp3-2.4.0
  mkdir build
  cd build
  cmake -DSTATICLIBS=ON ..
  make -j 4
  sudo make install
  cd

Now we can proceed for installing south plugin dnp3 for fledge. for this first clone to the source code and then install by follwing as given below
  
.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-dnp3.git
  cd fledge-south-dnp3
  mkdir build
  cd build
  export OPENDNP3_LIB_DIR=~/fledge-src/opendnp3-2.4.0
  export FLEDGE_ROOT=~/fledge-src/fledge
  cmake -DFLEDGE_INSTALL=/usr/local/fledge ..
  make -j 4
  sudo make install
  cd

Till now we have seen the installation of plugins written in c/c++. Now we will explore installation of pluins written in python.
  
Fledge-south-iec61850
-------

.. note::

  ``It is also required to have Fledge installed from the source code, not from the package repository.`` 

It has library dependency on libiec61850, so first clone to this library repository using the link https://github.com/mz-automation/libiec61850.git and then install it as below

.. code-block:: console

  cd fledge-src
  git clone https://github.com/mz-automation/libiec61850.git
  cd libiec61850
  mkdir build
  cd build
  cmake ..
  make -j 4
  sudo make install
  cd
  
Now we can proceed for installing south plugin 61850 for fledge. for this first clone to the source code and then install by follwing as given below
  
.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-iec61850.git
  cd fledge-south-iec61850
  mkdir build
  cd build
  export LIB_61850=~/fledge-src/libiec61850
  export FLEDGE_ROOT=~/fledge-src/fledge
  cmake -DFLEDGE_INSTALL=/usr/local/fledge ..
  make -j 4
  sudo make install
  cd
  

Fledge-south-http
-------
No dependencies we need to install this plugin


.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-http.git
  cd
  sudo cp -R ~/fledge-src/fledge-south-http/python/fledge/plugins/south/http_south /usr/local/fledge/python/fledge/plugins/south/
  
  
Fledge-south-mqtt
-------

Dependency on mosquitto. the list of dependencies file named requirements.txt is already included in the source file directory of south mqtt plugin. we can install all the dependencies by running the requirements.txt file with pip

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-mqtt.git
  cd fledge-south-mqtt/python
  pip3 install -r requirements-mqtt-readings.txt
  cd
  sudo cp -R ~/fledge-src/fledge-south-mqtt/python/fledge/plugins/south/mqtt-readings /usr/local/fledge/python/fledge/plugins/south/
  
With this we have explored the installation of some of the most useful south pluins. Now restart the fledge to explore and use the above installed plugins.


  
