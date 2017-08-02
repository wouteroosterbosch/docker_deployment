FROM rocker/shiny:latest

MAINTAINER John Doe "j.doe@gmail.com"

ADD . /project

RUN R -e "install.packages(c('shinydashboard', 'flexdashboard', 'leaflet', 'dplyr', 'ggpmap', 'tidyverse'))"

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]
