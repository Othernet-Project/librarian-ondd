==============
librarian-ondd
==============

A dashboard plugin used to control the ONDD system service. It allows it's user
to set the parameters required by the satellite tuner, show status information
about signal strength and quality, and view the currently active file transfers.

Installation
------------

The component has the following dependencies:

- librarian-core_
- librarian-dashboard_
- librarian-setup_
- ondd-ipc_

To enable this component, add it to the list of components in librarian_'s
`config.ini` file, e.g.::

    [app]
    +components =
        librarian_ondd

Configuration
-------------

``ondd.socket``
    Path to the socket for establishing a connection with the ONDD API.
    Example::

        [ondd]
        socket = /var/run/ondd.ctrl

Development
-----------

In order to recompile static assets, make sure that compass_ and coffeescript_
are installed on your system. To perform a one-time recompilation, execute::

    make recompile

To enable the filesystem watcher and perform automatic recompilation on changes,
use::

    make watch

.. _librarian: https://github.com/Outernet-Project/librarian
.. _librarian-core: https://github.com/Outernet-Project/librarian-core
.. _librarian-dashboard: https://github.com/Outernet-Project/librarian-dashboard
.. _librarian-setup: https://github.com/Outernet-Project/librarian-setup
.. _ondd-ipc: https://github.com/Outernet-Project/ondd-ipc
.. _compass: http://compass-style.org/
.. _coffeescript: http://coffeescript.org/
