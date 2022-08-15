********
Installation
********

Fledge installation
=====

In this we will be looking at Installing the fledge & its plugins from the source code. 
For fledge installation and usage, the following minimum files may be required:
- Install the fledge core package (simply named as fledge)
- Install the fledge GUI (graphical User Interface) to provide a user interface by which the user can interact with the fledge core. (normally named as fledge-gui)
- Fledge has a number of south plug-ins which support various industrial protocols. Install the specific south plug-in required out the available list according to the requirements. (named as fledge-south-plugin_name, ex: fledge-south-modbus for modbus plugin)
- Similarly, fledge has a number of North plugins which can connect you mostly to a cloud or another instance of fledge. 

.. note::

  Plugins can be added at any time as on when needed. So no need to install all plugins at the same time.

There are two ways to install fledge:
 
- Install from a downloaded •deb package
- Add fledge repository to apt sources list of raspberry pi and then install using

.. code-block:: console

  sudo apt-get install <package name>
  
Here we will be looking at installing the Fledge in Raspberry Pi 4 Model B, 8GB RAM, running Ubuntu Mate 20.04. The official documentation guide available at https://fledge-iot.readthedocs.io/en/latest/ does not cover this specific usecase and further the fledge repository is not available for Ubuntu mate 20.04, with aarch64 architecture. 
Thus the only option left with us is use the source code, compile, build and then install which will be explained in the further subsections.

Dependencies
=======

The following prerequisites are needed to build fledge from the source code. These are the tools and libraries that are required to compile and build the fledge source code. Install them using the beloow command

.. code-block:: console

  $ sudo apt-get install avahi-daemon curl cmake g++ make build-essential autoconf automake uuid-dev libtool libboost-dev libboost-system-dev libboost-thread-dev libpq-dev libssl-dev libz-dev python-dev python3-dev python3-pip python3-numpy postgresql sqlite3 libsqlite3-dev
  $

Source Directory
===========

Before proceeding to the installation, create a directory named *fledge-src* in the home directory to save allthe source files related to the fledge.

.. code-block:: console

  mkdir fledge-src

After creating the souce directory, the the next is to download the souce code from github repository by visiting https://github.com/fledge-iot . 
in the official reposotory search for the module and then use *git clone* to download the source code.

Fledge Core
===========

To explore any fledge module first we need to install fledge core alias **fledge** that manages and integrates all the other services and modules.

Download Source Code
-------

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge.git
  cd

Install
-------

to install fledge, change to the cloned fledge directory, do make and make install with Sudo.

.. code-block:: console

  cd fledge-src
  cd fledge
  make -j 4
  sudo make install
  cd
  
By default the installation will be placed in */usr/local/fledge* directory.

Verify
------

To verify the status of installation 

.. code-block:: console

  sudo /usr/local/fledge/bin/fledge status
  

Fledge Commands
------

Fledge provides various commands for th console to manage the fledge. They are

- **Start**: Start the Fledge system
- **Stop**: Stop the Fledge system
- **Status**: Lists currently running Fledge services and tasks
- **Reset**: Delete all data and configuration and return Fledge to factory settings
- **Kill**: Kill Fledge services that have not correctly responded to Stop
- **Help**: Describe Fledge options

For example, to start the Fledge system, open the console and type:

.. code-block:: console

  sudo /usr/local/fledge/bin/fledge start

Fledge-GUI
===========

This provides a web based grafical user interface to interact with fledge and enable us to configure the fledge as per our requirement.

Download Source Code
-------

.. code-block:: console

  cd fledge-src
  git clone https://github.com/fledge-iot/fledge-gui.git
  cd

Prerequisite
-------

for installing fledge GUI  we need another dependency tool and is nodejs.

.. note::

  node js can be installed simply by *sudo apt-get install nodejs*. But 
  this will install latest version, that fledge-gui may not support. The specific version of supported nodejs is 14.x. Please install this version only. In case you already had nodejs installed in your device then first uninstall it by *sudo apt remove nodejs* and then re-install using the bellow command

.. code-block:: console

  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt-get install nodejs

Build
-------

Fledge GUI can be build and installed using *./build --clean-start* option. to do this

.. code-block:: console

  cd fledge-src
  cd fledge-gui
  ./build --clean-start

.. note::

  this method run the installation process successfully but could not run fledge gui. So its better to choose the other option that is creating a Debian package & install it.

Create debian package
---------

Use ./make_deb script to create debian package, the package will be placed in packages/build/

.. code-block:: console

  cd fledge-src
  cd fledge-gui
  ./make_deb
  cd
  
it will build a •deb package & store it to *package/build* directory. we can go and check for the same in the above directory.

.. code-block:: console

  cd package/build
  ls
  
Install
--------

.. code-block:: console

  sudo cp packages/build/fledge-gui_1.9.2next-224.deb /var/cache/apt/archives/.
  sudo apt install /var/cache/apt/archives/fledge-gui_1.9.2next-224.deb

.. note::

  Version might be different from one to other.

Verify
-------

To verify the fledge-gui installation open any browser & enter the ip address (port is not required) or you can alos simply type localhost in case you are opening the browser in the host device. This should open an interactive fledge web gui in the browser. Through ip address it can be accessed from any sysytem browser in the same LAN.

.. note::
  Even without fledgegui , we could interact with fledge using curl via REST api. But fledge-gui will prove easy way for the same.
