A base image for monit
======================

docker-monit is a [Docker](http://www.docker.io) image that is configured
to be used directly or as a base for more customized applications for
[monit](http://www.mmonit.com/monit), the monitoring daemon.  docker-monit
is available for pulling from
[the Docker registry](https://index.docker.io/u/lgustafson/docker-monit)

This image includes monit version 5.14

Overview
--------

This image installs monit to the following location:

  * /opt/monit

Monit is configured to be executed as root within the container and will be run
as pid 1.The monit configuration file lives at:

  * /etc/monitrc

The supplied monitrc simply includes all .conf files at the following
locations:

  * /etc/monitrc.d
  * /etc/monit.d


Monit Configuration
-------------

By default, monit is configured as follows:

  * HTTP console running on port 2812
      * Username "admin" with password "monit" for admin access
  * Monit cycle is set to 60 seconds

Config files in /etc/monitrc.d typically should define the basic runtime
configuration of monit itself, while config files in /etc/monit.d should be
service checks.  This allows a user to use the basic runtime configuration
supplied by monit and add monit checks by mounting a directory of config files
(from the host, for instance) at /etc/monit.d.

Along the same lines, the runtime configuration can be completely replaced by
mounting a configuration directory to /etc/monitrc.d.

Docker Configuration
--------------------

Exposed Ports:
  * 2812 (Monit httpd)

Dependencies
------------

  * [ubuntu](https://registry.hub.docker.com/_/ubuntu/)

Examples
--------

    # Runs a container that will be deleted at shutdown with the following
	# properties:
	#   * exposes container port 2812 to the host
	#   * injects monit check configurations from the host at /tmp/monit.d
    docker run --rm --name "test-docker-monit" -p 2812:2812 -v /tmp/monit.d/:/etc/monit.d lgustafson/docker-monit:latest
