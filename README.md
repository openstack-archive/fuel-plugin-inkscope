Inkscope plugin for Fuel
===================

Inkscope plugin
---------------

Overview
--------

Inkscope is a Ceph admin and supervision interface. It relies on API provided by ceph. It use mongoDB to store real time metrics and history metrics.

Manual installation is fully described in the inkScope wiki : https://github.com/inkscope/inkscope/wiki

Inkscope fuel plugin's install and configure all Inkscope components


Requirements
------------

| Requirement                      | Version/Comment                                               |
|----------------------------------|---------------------------------------------------------------|
| Mirantis Openstack compatibility | 6.1                                                           |
|----------------------------------|---------------------------------------------------------------|
| Ceilometer with local database   | You have to activate Ceilometer deployment with local mongoDB |
|----------------------------------|---------------------------------------------------------------|
| Ceph environement                | You have to use Ceph                                          |

Recommendations
---------------

None.

Limitations
-----------

Inkscope plugin only works for Ubuntu OS at the moment
Inkscope plugin can't use external mongo DB

Installation Guide
==================

Https plugin installation
----------------------------

1. Clone the fuel-plugin repo from: https://github.com/stackforge/fuel-plugin-inkscope.git

    ``git clone``

2. Install the Fuel Plugin Builder:

    ``pip install fuel-plugin-builder``

3. Build inkscope Fuel plugin:

   ``fpb --build fuel-plugin-inkscope/``

4. The inkscope-<x.x.x>.fp file will be created in the plugin folder (fuel-plugin-inkscope)

5. Move this file to the Fuel Master node with secure copy (scp):

   ``scp inkscope-<x.x.x>.fp root@:<the_Fuel_Master_node_IP address>:/tmp``
   ``cd /tmp``

6. Install the inkscope plugin:

   ``fuel plugins --install inkscope-<x.x.x>.fp``

6. Plugin is ready to use and can be enabled on the Settings tab of the Fuel web UI.

User Guide
==========

Inkscope plugin configuration
-----------------------------

1. Create a new environment with the Fuel UI wizard

2. Choose Ceilometer in additional component to install

3. Click on the settings tab of the Fuel web UI

4. Scroll down the page, select the "Inkscope plugin" checkbox and check it

5. Activate all Ceph backend


Deployment details
------------------

1. Create a new mongo database

2. Install Cephprobe on controller node

3. Install Sysprobe on Ceph-osd and controller node

4. Install InkscopeViz tool on controller node and configure it on haproxy

5. Start Cephprobe, Sysprobe , restart haproxy & apache service


Known issues
------------

None.

Release Notes
-------------

**1.0.0**

* Initial release of the plugin

