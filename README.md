# docker-php-dev-env

Some configuration to start using Docker for PHP development.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development.

### Prerequisites

You need a linux computer and docker 1.8+ with docker-compose 1.5+.
OSX will also work but with very bad performance.

### Installing

Start by cloning the repository anywhere on your computer.

    $ git clone https://github.com/le-phare/docker-php-dev-env.git
    $ cd docker-php-dev-env

#### Launch the generic stack

Go to the generic folder and launch the docker-compose up command.

    $ cd generic
    $ docker-compose up

#### Launch the project stack

Go to the project folder and launch the docker-compose up command. Note that the first time it will take several minutes to build the images.

    $ cd ../project
    $ docker-compose up

Now you need to add the project hostname to your hosts file.

    $ su -c 'echo "127.0.0.1 my-project.dev" >> /etc/hosts'

#### Test everything work

Launch your prefered browser and go to [http://my-project.dev]. If you see a phpinfo page then everything as worked nicely ! If not take a look at the [Resolve problems](#resolve-problems) section.

### Working with multiples projects

The `generic` and `project` folder does not have to be kept together. You need one generic folder but you can have as many project you want.
To use the project stack in an existing project, you need to copy all files in the `project` folder to the root of your project.

### Customize

#### Change the .dev domain

To use another domain you need to edit both `generic/.env` and `project/.env` and set the `DEV_DOMAIN` environment variable.

#### Use SSL

To use SSL you need to generate a certificate in `generic/ssl_certs`.

You can use one self-signed certificate for all your project but you will get a warning in your brower because the hostname does not match the certificate hostname.

Or you can generate a self-signed certificate for each domain.

Both solution require to set the `CERT_NAME` environment variable in `project/.env`. The value must be the name of a file stored in `generic/ssl_certs`.

#### Customize apache or php images

You can edit the Dockerfile to adjust your need. For example if you need a specific php extension you will need to edit the `project/php/Dockerfile`.

#### Add containers

You can add as many containers as you want in either the generic or the project stack. You only need to be careful to the network thoses container will join to be accessible by others containers.

### The next level

If you have many projects you should consider to build apache and php images separatly and then reference them in the `project/docker-compose.yml`. You need to replace the `build: ...` lines by `image: <my/image>`.

### <a name="resolve-problems"> Resolve problems

TODO
