# Deploying Analytics products using Docker and Bluemix

Even though finding analytical insights in a given dataset is already quite a bit of work, often people want to access some of the analytics reports, dashboards, etc. later on for further exploration.

> Note: when testing out the Docker files provided here, make sure your versions of Docker is set up to use Linux containers. On Windows, for newer versions of Docker, this means making sure that the "Switch to Linux Containers" is on. For older versions, it means using boot2docker.

## Creating a containerized application: Manually

When deploying analytics dashboards with interactive components, one option is to do this using a Shiny webserver. We will pull a base image with Shiny Server pre-installed from the public Docker repository, DockerHub. The image we will be using is `rocker/shiny`.

If we want to run this base image on our local Docker setup, we can run the following in the CLI:
`docker create -p 3838:3838 rocker/shiny`

The first time you execute this code, it might take a while to run, as the entire base image has to be downloaded from DockerHub.

Once that is done, run `docker ps` in your CLI to make sure the container is up and running. Take note of the name of your container, you will need it later on.

With our container up and running, there are two things left to do for us:
1. Copy our application code into the container
1. Install any additional dependencies not included in the base image.

First, let's make sure our application files are included in the Docker image. Docker provides us with a tool to copy files from our host system to the container and vice versa. To do this, you are going to need the name of your container that we told you to take note of just a moment ago! The app directory under `shiny-server` can be named however you choose. We rename the file `index.rmd` to make sure it is the default dashboard that Shiny Server will try to load in that directory.

`docker cp "fdb_demo.rmd" <YOUR_CONTAINER_NAME>:srv/shiny-server/<APP_NAME>/index.rmd`

This file should now be accessible via `127.0.0.1:3838/<APP_NAME>`. If no data can be found at that address, make sure that you have included `runtime: shiny` in the YAML for your flexdashboard file. For more info, see [here](http://rmarkdown.rstudio.com/flexdashboard/shiny.html).

Let's now add some extra packages and dependencies to the image. Our chosen base image was built on Linux, so it comes with a bash prompt. To access this prompt, we can run the following in our CLI:

`docker exec -it <YOUR_CONTAINER_NAME> bash`

That should bring us to our image's command shell. Now we can manually update and include some of our other dependencies. For example, if I want to update the container's software, install Git, and install some extra R packages, I could run this:

```
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get install -y git
$ sudo R -e "install.packages(c("shinydashboard", "leaflet", "dplyr", "ggpmap", "tidyverse"))"
```

> If you are running your container / application locally, it is possible to mount your application directory as a volume, rather than including it in your image. Since the current exercise is focused on making sure team members can share and expose their application, we won't consider this option in this walkthrough. For more information, see [here](https://hub.docker.com/r/rocker/shiny/)).

Open questions:
* What is the best way to integrate with (Enterprise) Git?

docker commit
More info [here](https://docs.docker.com/engine/reference/commandline/commit/)

Now you can put this dockerfile anywhere


## Bluemix static


## Bluemix Toolchain

Dockerfile (good starting point [here](https://www.r-bloggers.com/r-3-3-0-is-another-motivation-for-docker/))

demo:
FROM rocker/shiny:latest

MAINTAINER John Doe
"j.doe@gmail.com"

ADD . /project

RUN R -e "install.packages(c("shinydashboard", "leaflet", "dplyr", "ggpmap", "tidyverse"))"

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]

## Other options

* Watson ML
* Node.js
* Secure toolchain? (available outside US?)

## Links

[A beginner's guide to the Dockerfile](https://blog.codeship.com/a-beginners-guide-to-the-dockerfile/)
[Create and use a simple container toolchain](https://www.ibm.com/devops/method/tutorials/tutorial_toolchain_container?task=3)




0647320639
