Prometheus TimeSeries DataBase (TSDB) and Grafana Dashboards
============================================================

Usage
-----

Starting the services
~~~~~~~~~~~~~~~~~~~~~

Build the custom `random`` image and pull service images from Docker Hub:

::

    $ docker-compose build random-one
    $ docker-compose pull

Create volumes and networks, start services:

::

    $ docker-compose up -d

    Creating network "prometheus-grafana_ripley" with the default driver
    Creating prometheus-grafana_random-three_1  ... done
    Creating prometheus-grafana_random-one_1    ... done
    Creating prometheus-grafana_prometheus_1    ... done
    Creating prometheus-grafana_node-exporter_1 ... done
    Creating prometheus-grafana_random-two_1    ... done
    Creating prometheus-grafana_grafana_1       ... done


This will start the following services:

- a Prometheus time series database to gather and store metrics;
- a Grafana server to create dashboards and visualize data;
- a Node Exporter collection engine to gather and expose system metrics;
- threeinstances of the ``random`` example service that generates and exposes
  random metrics.

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

Prometheus
~~~~~~~~~~

Docker images:

- https://hub.docker.com/r/prom/prometheus/

Documentation:

- https://prometheus.io/
- https://prometheus.io/docs/prometheus/latest/getting_started/
- https://prometheus.io/docs/prometheus/latest/installation/#using-docker

Guides:

- https://www.brianchristner.io/how-to-setup-prometheus-docker-monitoring/
- https://www.brianchristner.io/updated-docker-monitoring-prometheus-grafana/
- https://github.com/firehol/netdata/wiki/Netdata,-Prometheus,-and-Grafana-Stack

Sources:

- https://github.com/prometheus/prometheus

Grafana
~~~~~~~

Docker images:

- https://hub.docker.com/r/grafana/grafana/

Documentation:

- http://docs.grafana.org/
- http://docs.grafana.org/installation/docker/
- http://docs.grafana.org/guides/getting_started/
- http://docs.grafana.org/features/datasources/prometheus/

Sources:

- https://github.com/grafana/grafana

Node Exporter
~~~~~~~~~~~~~

Docker images:

- https://hub.docker.com/r/prom/node-exporter/

Guides:

- https://prometheus.io/docs/guides/node-exporter/


Sources:

- https://github.com/prometheus/node_exporter

Dashboards:

- https://grafana.com/dashboards/1860

"Random" service
~~~~~~~~~~~~~~~~

Tutorial:

- https://prometheus.io/docs/prometheus/latest/getting_started/

Sources:

- https://github.com/prometheus/client_golang/blob/master/examples/random/main.go
