South Plugin
======

Fledge has various south plugins that can be used to acquire data from various south sensors or devices. It supports most of the common industrial communication protocols. In this section we will look at how to install the required south plugins from source code.

Before proceeding to install suth plugins, make sure that you have already installed. If not refer to fledge installation section. And further while installing any of the fledge plugins it's better to stop the fledge first and then proceed for the installtion. Once the installtion is over you can restart the fledge to get the chages effect and continue to use.

Fledge-south-iec-104
-------

This is the plugin used for communicating with the south field devices that supports IEC-60870-5-104. The field device will act as a server and the fledge will act as client.


.. note::

  ``It is also required to have Fledge installed from the source code, not from the package repository.`` 

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-iec104.git
  cd

Fledge-south-modbus-c
-------

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-modbus-c.git
  cd

Fledge-south-dnp3
-------

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-dnp3.git
  cd
  
Fledge-south-http
-------

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-http.git
  cd
  
Fledge-south-iec61850
-------

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-iec61850.git
  cd
  
Fledge-south-mqtt
-------

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-south-mqtt.git
  cd


  
