FROM rocker/shiny:latest

MAINTAINER John Doe "j.doe@gmail.com"

ADD . /srv

RUN mkdir /srv/shiny-server/test/
RUN mv /srv/fdb_demo.rmd /srv/shiny-server/test/index.rmd

RUN R -e "install.packages(c('shinydashboard', 'flexdashboard', 'leaflet', 'dplyr', 'ggpmap', 'tidyverse'))"

EXPOSE 3838

CMD ["/usr/bin/shiny-server.sh"]
