FROM rocker/shiny-verse:latest
RUN apt-get update && apt-get install -y git \
    libudunits2-dev \
    libgdal-dev \
    libgeos-dev \
    libproj-dev \
    libmysqlclient-dev

RUN git clone https://github.com/m-wile/fintechGolemApp.git
RUN R -e "install.packages(MetalComms)"

EXPOSE 3838

CMD ["/init, shiny::runApp(port = 3838)"]
