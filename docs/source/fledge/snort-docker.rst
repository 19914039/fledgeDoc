Running snort3 using Docker
=====

This section will explain about the installation and working with snort3 using Docker.

.. note::

  Actually there is an official docker image available from cisco talos. I have faced some issues while running the snort like DAQ socket operation not permitted. I searched over the web buit could't find any thing helpful.
  
In this section we will see

1. Writing `Dockerfile` to build the image for snort3

2. how to build our own a doker image for snort3 using `Dockerfile`

3. Running the snort3 in docker container

4. Configuring the snort3

5. Testing the snort3

6. Unix-socket alert feature of Snort3

1. Writing `Dockerfile` to build the image for snort3
=====

For building a docker image we can take the help of ``Dockerfile``. Basically ``Dockerfile`` is a text file that contains set of instructions sequenctially to be execuited to build the docker image. Some basic referecnce about this can be found at https://docs.sevenbridges.com/docs/upload-your-docker-image-with-a-dockerfile 

Follow the below instaructions to write the docker file for snort3

.. code-block:: console

  # open the bash and `cd` to your current directory, it could be home or Desktop anything that where you want to save the Dockerfile
  # for example in my case it is ~/Desktop/snort-docker
  
  cd ~/Desktop/snort-docker
  nano Dockerfile
  # a new file will be created where we will now eneter the instructions to build the docker image

The instructions can be found in ``Dockerfile`` available in the source directory or at link https://github.com/19914039/snort-raspi/blob/main/Dockerfile
  
After entering the above press ctrl+o and Enter, then ctrl+x

2. how to build our own a doker image for snort3 using ``Dockerfile``
=======

.. code-block:: console

  # if you are not in the same directory then chage it to it first (where Dockerfile is present)
  cd ~/Desktop/snort-docker
  docker build -t snort-docker
  # snort-docker is the name of the image that we will be creating. It's your choice
  
3. Running the snort3 in docker container
=======

.. code-block:: console

  sudo docker run -it --rm --net=host -v /tmp:/tmp snort-docker /bin/bash
  
  # -it - Interactive mode
  # --net=host - It is required to give permission to access the host network interface
  # -v .tmp:/tmp  - this is for creating a common unix-socket for the docker container and the host system
  
4. Configuring Snort3
=======

Snort-configuration
-----

.. code-block:: console

  # first of all we need to configure the snort configuration file
  nano /usr/local/etc/snort/snort.lua
  # change the parameters HOME_NET='<hostIP>'
  # in my case it is 10.12.1.100, so HOME_NET='10.12.1.100'
  # change EXTERNAL_NET = '!$HOME_NET'
  
  # To change the output configuration scroll down to section 7
  # remove -- infront of alert_fast and alert_unixsock
  
  
After entering the above press ctrl+o and Enter, then ctrl+x

Snort-Rule
-----

.. code-block:: console

  # we need to enter the rule set on which snort should trigger alert
  nano /usr/local/etc/rules/local.rules
  # enter the bello line 
  alert icmp any any -> $HOME_NET any (msg:"ICMP Alert Test";)
  
After entering the above press ctrl+o and Enter, then ctrl+x

5. Testing snort3
======

.. code-block:: console

  snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules -A alert_fast -i eno1
  
Now send a ping command from any other system to your snort3 host system. It should show the alert on the screen.

.. code-block:: console

  ping 10.12.1.100

Snort will be displaying the alerts on the console.

6. Unix-socket alert feature of Snort3
=======

first prepare the socker listener code in Python as below, open a new bash

.. code-block:: console

  # Python code for unix socket
  nano snort-unix-alert.py

The instructions/code can be found in ``snort-unix-alert.py`` available in the source directory or at link https://github.com/19914039/snort-raspi/blob/main/snort-unix-alert.py

After entering the above press ctrl+o and Enter, then ctrl+x. Then execuite it by using
  
.. code-block:: console  
  
  python3 snort-unix-alert.py
  
Now go to the docker window (bash) and run the snort in unixsocket alert mode  

.. code-block:: console

  snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules -A alert_unixsock -l /tmp -i eno1
  
Now send a ping command from any other system to your snort3 host system. It should show the alert on the screen.

.. code-block:: console

  ping 10.12.1.100

Alerts will be getting displayed on the second bash (snort-socket.py)

7. Unix-socket alert Sending over MQTT
=======

In the previous section we have seen how to listen and parse the snort3 alerts sending at unix-socket. Now we will explore how can we further forward this alert meassages to any other 3rd party using the MQTT broker. Since Alarm is an event related, we have choosen MQTT to transfer the alert event message.

.. note::

  We don't need any changes in the snort docker image. We can use the same previous image/container to test this feature. 

Now we meed little modifications in the python code that we have used previously. just we need to add the MQTT client that is publishing the Alert message received at the unix-socket. You can refer to the file https://github.com/19914039/snort-raspi/blob/main/snort-unix-alert-mqtt.py

Dependency Installation
-----

This has a python library dependency on paho-mqtt and can be installed by 

.. code-block:: console

  pip3 install paho-mqtt

at the same time we also need to have MQTT brocker (mosquitto). This can be installed by 

.. code-block:: console

  sudo apt-add-repository ppa:mosquitto-dev/mosquitto-ppa
  sudo apt-get update
  sudo apt-get install mosquitto
  sudo apt-get install mosquitto-clients
  sudo service mosquitto start


Testing
-----
1. send a ping command from any other system to your snort3 host system.

.. code-block:: console

  ping 10.12.1.100

2. Open a new bash in the host system and run mqtt subscriber to listen on snort-alerts that are published by the mqtt-publisher

.. code-block:: console

  mosquitto_sub -h 10.12.1.100 -t "Alert/Snort"
  
3. Open new bash and run the python file 

.. code-block:: console  
  
  python3 snort-unix-alert-mqtt.py
  
4. open new bash and Start the snort docker container using 
  
.. code-block:: console

  snort -c /usr/local/etc/snort/snort.lua -R /usr/local/etc/rules/local.rules -A alert_unixsock -l /tmp -i eno1
  
Now you can notice that in the second bash (mosquitto_sub bash window), The alerts are getiing dispalyed on the console


