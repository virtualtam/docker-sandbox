Sentry Error Tracking
=====================

Usage
-----

Starting Sentry
~~~~~~~~~~~~~~~

Generate an environment file for Docker Compose from the provided template:

::

    $ make .env


Initialize the database, apply migrations and create the first admin user:

::

    $ docker-compose up -d memcached postgres redis
    $ docker-compose run sentry sentry upgrade


Start the Sentry web, cron and worker services:

::

    $ docker-compose up -d

Cleanup
~~~~~~~

To stop all services:

::

    $ docker-compose down

To stop all services and remove data volumes:

::

    $ docker-compose down -v

Resources
---------

Sentry
~~~~~~

- `Home page <https://sentry.io/welcome/>`_
- `Installation with Docker <https://docs.sentry.io/server/installation/docker/>`_
- `Docker library documentation <https://docs.docker.com/samples/library/sentry/>`_
- `Docker image source repository <https://github.com/getsentry/docker-sentry>`_
