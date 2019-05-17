Minetest Server
===============

Usage
-----

Starting the server
~~~~~~~~~~~~~~~~~~~

Build the server image:

::

    $ docker-compose build minetest


Start the Minetest server:

::

    $ docker-compose up -d


Installing games and mods
~~~~~~~~~~~~~~~~~~~~~~~~~

Optionally, install games and mods:

::

    $ docker-compose exec minetest bash
    $ cd games
    $ git clone https://repo.or.cz/MineClone/MineClone2.git mineclone2


Copying worlds
~~~~~~~~~~~~~~

It might be easier to generate a world from the Minetest game client interface,
and then copy it to the server.

The following example assumes the world named ``world`` has been generated
locally, and all necessary games and mods are present on the containerized server:

::

    $ CONTAINER=$(docker ps --format "{{.Names}}" | grep minetest)
    $ docker cp ${HOME}/.minetest/worlds/world ${CONTAINER}:/minetest/worlds/world


Then, restart the server:

::

    $ docker-compose restart minetest
