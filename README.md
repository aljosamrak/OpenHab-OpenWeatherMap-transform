OpenHab OpenWeatherMap Transform
===================

openHAB allows you to post HTTP queries over the internet, and to put the received data in items that you can use in your rules. In most cases, you will get the information you need into a XML structured document, and you need a way to extract only the value you want: here is where XSLT transformations come in our help. XSLT is a standard method to transform an XML structure into a document with the structure you want. You can find a very good tutorial here: XSLT tutorial at W3Schools

<sup><sub>copied from: https://github.com/openhab/openhab/wiki/Samples-XSLT-Transformations</sup></sup>


This repository contains a set of transforms for OpenWeatherMap. It contains the same set of transforms as the Yahoo weather transforms.


1. Prerequisites
================

You need to have OpenHab installed and "http binding" in addons folder.
Bindings can be downloaded as addons from: http://www.openhab.org/downloads.html


2. Checkout
===========

Checkout the source code from GitHub in root of your OpenHab installation, e.g. by running


    cd <your_openhab_install_directory>
    git clone https://github.com/aljosamrak/OpenHab-OpenWeatherMap-transform.git


3. Usage
======================
This is the url for today's weather:

    http://api.openweathermap.org/data/2.5/weather?q=< city_name >&mode=xml

This is the url for tomorrow's weather:

    http://api.openweathermap.org/data/2.5/forecast/daily?q=< city_name >&mode=xml&units=metric&cnt=1

Replace < city_name \> with the name of the city you want the weather for. More about API on http://openweathermap.org/api

To use it, put this line in your items file. Than you can show it in your sitemap. This is the basic usage.

    Number temperature_out   "Temperature [%.1f °C]"   <temperature>   {http="<[http://api.openweathermap.org/data/2.5/weather?q=< city_name >&mode=xml:3600000:XSLT(openweathermap_temperature.xsl)]" }

For forcast use this:

    Number forecast_T_H_out  "Tomorrow's Temperature high [%.1f °C]"   <temperature>   {http="<[http://api.openweathermap.org/data/2.5/forecast/daily?q=< city_name >&mode=xml&units=metric&cnt=1:3600000:XSLT(openweathermap_forecast_high.xsl)]" }


3. Advanced
======================

If you want a litle bit more advanced. In your config file < openhab\_install\_direstory >/openhab.cfg at "HTTP Binding" add this lines.

    # configuration of the second cache item  
    http:openWeatherMap.url=http://api.openweathermap.org/data/2.5/weather?id=3194452&mode=xml&units=metric
    http:openWeatherMap.updateInterval=3600000
    http:openforecast.url=http://api.openweathermap.org/data/2.5/forecast/daily?id=3194452&mode=xml&units=metric&cnt=1
    http:openforecast.updateInterval=3600000

This chaches the data to openWeatherMap and openforecast. Change the item bindings to:

    Number temperature_out   "Temperature [%.1f °C]"   <temperature>   {http="<[openWeatherMap:3600000:XSLT(openweathermap_temperature.xsl)]" }

    String forecast_out   "Tomorrow's weather: [MAP(openweathermap.map):%s]"   {http="<[openforecast:3600000:XSLT(openweathermap_forecast_icon.xsl)]" }

Items retrieve crashed data. This is useful if you have have multiple item bindings. This way data is retrieved only once from server and acced multiple times.

For changing icon depending on weather put this in *.items file:

    String weather   "Today's weather: [MAP(openweathermap.map):%s]"   {http="<[openWeatherMap:3600000:XSLT(openweathermap_icon.xsl)]"}

and this *.sitemap file:

    Text item=weather icon="openweathermap"

You can change weather icons. icons are in < openhab\_install\_direstory >/webapps/images. Icons name must be "openweathermap_*" where * is zhe name of specific icon. Name are:

Day  | Night
------------- | -------------
01d.png | 01n.png | sky is clear
02d.png | 02n.png | few clouds
03d.png | 03n.png | scattered clouds
04d.png | 04n.png | broken clouds
09d.png | 09n.png | shower rain
10d.png | 10n.png | Rain
11d.png | 11n.png | Thunderstorm
13d.png | 13n.png | snow
50d.png | 50n.png | mist
