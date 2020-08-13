# Ritchie Formula for get weather for a city

## Description

This is a [Ritchie](https://ritchiecli.io/) formula was develop use [OpenWeatherMap](https://openweathermap.org/) to get forecast weather for a city.

For run this formula you need:

**1 -** Get a token in the OpenWeather.

**2 -** Add this repo as Ritchie repository, run `rit add repo` and follow steps of cli.

**3 -** Install python dependencies

```bash
pip install -r requirements.txt
```

**4 -** Add OpenWeatherMap token using `rit set credential`, select *new*, use as token name *openweathermap* and add token value.

**5 -** Run formula

```bash
rit weather python
```

## Issues, bugs and comments

Please, if you have any comment, idea, bug or suggestion. Open a issue or reach out me on [twitter](https://twitter.com/fernandoike).