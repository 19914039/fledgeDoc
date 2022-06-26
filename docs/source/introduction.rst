Introduction
======
.. Images
.. |fledge_architecture| image:: images/fledge_architecture.png

Fledge is an open-source project ment for industrial IoT (IIoT) applications. It has mainly the following components:

- **South services**: used to interact with the sensors and actuators (downstream data flow)
- **North services**: used to interact with the cloud or any other (may be another fledge) (upstream data flow)
- **Storage**: used to buffer the readings/data and will provide temporary storage. (default is SQLite)
- **REST API**: used by the external applications to interact with the fledge for data reading and configuration changes etc. It will form a data pipe to access the readings/data from the storage.
- **Notification servives** used to trigger some actions or notifications upon matching of specified conditions.
|fledge_architecture|
