# simple-weather-widget
A simple weather widget for [Übersicht](http://tracesof.net/uebersicht/) by DarkSky API.

## ScreenShot

![Screenshot](https://github.com/85Ryan/simple-weather-darksky.widget/blob/master/screenshot.png)

## Setup
1. Install [Übersicht](http://tracesof.net/uebersicht/)
2. Download and unzip this repo, rename the file with `simple-weather-darksky.widget`.
3. Put the `simple-weather-darksky.widget` file in your Übersicht widget folder.
4. This widget requires an API key from the [DarkSky API](https://darksky.net/dev). Before you use this widget, open `index.coffee`, and change the variable apiKey to the key you got from DarkSky API.
5. You can change the units format (si or us) in `index.coffee`.
6. The widget uses the new Geolocation API to find your location automatically. Requires Übersicht 0.5 or later to work.

## OpenWeatherMap VERSION
If you want to use the OpenWeatherMap API, see this:
https://github.com/85Ryan/simple-weather.widget

## Credits
Icons by Erik Flowers: http://erikflowers.github.io/weather-icons/
