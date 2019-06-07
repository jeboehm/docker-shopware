# docker-shopware
[![Build Status](https://travis-ci.org/jeboehm/docker-shopware.svg?branch=master)](https://travis-ci.org/jeboehm/docker-shopware)

Run Shopware in a Docker container.

Installation:
- Install docker and docker-compose.
- Copy the `docker-compose.yml` to a new local project directory. You don't need the other files.
- Run `docker-compose up` and wait until the installation process is finished.
- You can now access Shopware via [http://127.0.0.1:8080](http://127.0.0.1:8080) (The default backend login is `demo/demo`).

## Images

If you cannot see the demo images, run ```bin/console sw:media:migrate``` in your container.
You can also just run ```docker-compose run --rm shopware mediamigrate```.

## Cronjobs

Run your cronjobs by executing ```docker-compose run --rm shopware cron```.
