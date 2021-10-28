# ft_server


 
## :whale: Description

An automated installation of a LEMP server inside a Docker container.

This project uses a dockerfile to set up an Nginx server with a few services on top of the debian buster image for Docker.

This project is part of the common core at 42 Madrid Coding School and serves as an introduction to system administration and Docker.

## :nut_and_bolt: How it works

The container uses Debian Buster as the OS, then the Nginx server is configured and MariaDB, PhpMyAdmin and Wordpress services are deployed. Additionally, a SSL certificate is created.

This is automated thanks to a dockerfile and a sh script:

- Dockerfile is responsible of creating the container with the Debian Buster image as the base image. It will also copy a few config files and the Wordpress files into the container from the src folder. Finally it will execute the init.sh script.

- The script will handle creation of the SSL certificate , configuration for Nginx and the services. It will also grant needed permissions and start all the services.  



## How to use



1. Open terminal inside the repo
2. Build the image from the dockerfile with: $ docker build -t [image name]
3. Run a container from the image: with $ docker run --name [container-name] -d -p 80:80 -p 443:443 [image name]
4. Access the index page from your browser using localhost

If you want to interact with the container via CLI, run the following command: docker exec -it [container-name] bash






---