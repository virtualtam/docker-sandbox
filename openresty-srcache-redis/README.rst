OpenResty request cache with Redis
==================================

Usage
-----

Starting the services
~~~~~~~~~~~~~~~~~~~~~

Build a custom OpenResty image, pull service images from Docker Hub:

::

    $ docker-compose build openresty
    $ docker-compose pull

Create volumes and networks, start services:

::

    $ docker-compose up -d --scale openresty=4


Check all services are running:

::

    $ docker-compose ps

Check load balancing and caching
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Watch OpenResty logs to ensure HTTP traffic is properly load-balanced:

::

    $ docker-compose logs -f openresty

If the application is unreachable and OpenResty backends are not hit, check the
Compose configuration and ensure the ``traefik.docker.network`` option is
properly set (see Træfik resources below).

Check the Redis cache is used when calling Shaarli API endpoints:

::

    $ redis-cli keys "*"

Or alternatively:

::

    $ watch 'redis-cli keys "*"'

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

Redis
~~~~~

Docker images:

- https://hub.docker.com/_/redis/

Nginx - OpenResty
~~~~~~~~~~~~~~~~~

Documentation:

- https://openresty.org/en/
- https://openresty.org/en/linux-packages.html
- https://openresty.org/en/redis-nginx-module.html
- https://openresty.org/en/redis-2-nginx-module.html

Sources:

- https://github.com/openresty
- https://github.com/openresty/openresty

Docker images:

- https://hub.docker.com/r/openresty/openresty/
- https://github.com/openresty/docker-openresty

Cache control and headers:

- https://stackoverflow.com/questions/19002567/nginx-add-header-and-cache-control
- https://serverfault.com/questions/772507/set-expires-and-cache-control-headers-on-nginx
- https://www.photographerstechsupport.com/tutorials/hosting-wordpress-on-aws-tutorial-part-4-wordpress-website-optimization/#ccheaders
- https://serverfault.com/questions/609350/update-cache-control-max-age-when-srcache-returns-response-from-cache
- https://groups.google.com/forum/#!topic/openresty-en/N-MqS1zLMiQ
- https://github.com/openresty/headers-more-nginx-module

Caching modules:

- https://github.com/openresty/srcache-nginx-module
- https://github.com/openresty/srcache-nginx-module#caching-with-redis
- https://github.com/openresty/srcache-nginx-module#srcache_response_cache_control
- https://www.nginx.com/resources/wiki/modules/redis/?highlight=redis
- https://github.com/openresty/redis2-nginx-module

Proxying:

- https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/
- https://www.liaohuqiu.net/posts/nginx-proxy-pass/
- https://stackoverflow.com/questions/12847771/configure-nginx-with-proxy-pass

Configuration:

- https://stackoverflow.com/questions/5238377/nginx-location-priority

Debugging and logging:

- https://nginx.org/en/docs/debugging_log.html
- http://www.nginx-discovery.com/2011/04/day-46-how-to-debug-location-in-nginx.html

Træfik
~~~~~~

Træfik options:

- https://docs.traefik.io/configuration/backends/docker/
- https://docs.traefik.io/configuration/commons/

Examples:

- https://www.katacoda.com/courses/traefik/deploy-load-balancer

Relevant backend labels:
- traefik.port
- traefik.docker.network
- traefik.backend.loadbalancer.method
- traefik.backend.loadbalancer.stickiness

Gateway timeout and overlay network setup:

- https://github.com/containous/traefik/issues/979
- https://github.com/containous/traefik/issues/1254
- https://github.com/containous/traefik/issues/3599
