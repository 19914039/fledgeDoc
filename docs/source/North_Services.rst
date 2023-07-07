North Plugins
========

Fledge has various north plugins that can be used to communicate with the cloud or other higher level instalce of fledge.

fledge-north-azure
--------

This plugin used to communicate with Azure cloud services.
The list of dependencies file named requirements.txt is already included in the source file directory of azure plugin. we can install all the dependencies by running the requirements.txt file with pip


.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-north-azure.git
  cd fledge-north-azure/python
  pip3 install -r requirements-azure.txt
  cd
  sudo cp -R ~/fledge-src/fledge-north-azure/python/fledge/plugins/north/azure /usr/local/fledge/python/fledge/plugins/north/

fledge-north-gcp
--------

This plugin used to communicate with Google cloud services.
The list of dependencies file named requirements.txt is already included in the source file directory of thecb plugin. we can install all the dependencies by running the requirements.sh file.


.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-north-gcp.git
  cd fledge-north-gcp
  ./requirements.sh
  mkdir build
  cd build
  export FLEDGE_ROOT=~/fledge-src/fledge
  cmake -DFLEDGE_INSTALL=/usr/local/fledge ..
  make -j 4
  sudo make install
  cd
  
Fledge-north-iec-104
-------

Makes the fledge to act as IEC-104 Server.

.. note::

  ``It is also required to have Fledge installed from the source code, not from the package repository.`` 

dependency on lib60870 which we have already installed during south plugin installation. if need refer to the section `Fledge-south-iec-104`_ 

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-north-iec104.git
  cd fledge-north-iec104
  mkdir build
  cd build
  export LIB_104=~/fledge-src/lib60870/lib60870-C
  export FLEDGE_ROOT=~/fledge-src/fledge
  cmake -DFLEDGE_INSTALL=/usr/local/fledge ..
  make -j 4
  sudo make install
  cd


Fledge-north-http-c
-------

Makes the fledge to communicate with another instance of fledge.

No dependency required.

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-north-http-c.git
  cd fledge-north-http-c
  mkdir build
  cd build
  export FLEDGE_ROOT=~/fledge-src/fledge
  cmake -DFLEDGE_INSTALL=/usr/local/fledge ..
  make -j 4
  sudo make install
  cd
  
 
