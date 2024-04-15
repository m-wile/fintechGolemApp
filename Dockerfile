FROM rocker/shiny-verse:latest
RUN apt-get update && apt-get install -y git \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libmysqlclient-dev

RUN git clone https://github.com/m-wile/fintechGolemApp.git /srv/shiny-server/MetalComms
RUN Rscript /srv/shiny-server/MetalComms/packages.R

EXPOSE 3838

CMD ["/init"]