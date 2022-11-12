#!/usr/bin/env python
"""
Cleaned up version of the default weather plugin.

Credits to @bjesus for the initial code.
https://gist.github.com/bjesus/f8db49e1434433f78e5200dc403d58a3
"""

import json
from datetime import datetime

import requests

WEATHER_SYMBOL = {
    "Unknown": "✨",
    "Cloudy": "☁️",
    "Fog": "🌫",
    "HeavyRain": "🌧",
    "HeavyShowers": "🌧",
    "HeavySnow": "❄️",
    "HeavySnowShowers": "❄️",
    "LightRain": "🌦",
    "LightShowers": "🌦",
    "LightSleet": "🌧",
    "LightSleetShowers": "🌧",
    "LightSnow": "🌨",
    "LightSnowShowers": "🌨",
    "PartlyCloudy": "⛅️",
    "Sunny": "☀️",
    "ThunderyHeavyRain": "🌩",
    "ThunderyShowers": "⛈",
    "ThunderySnowShowers": "⛈",
    "VeryCloudy": "☁️",
}

WWO_CODE = {
    "113": "Sunny",
    "116": "PartlyCloudy",
    "119": "Cloudy",
    "122": "VeryCloudy",
    "143": "Fog",
    "176": "LightShowers",
    "179": "LightSleetShowers",
    "182": "LightSleet",
    "185": "LightSleet",
    "200": "ThunderyShowers",
    "227": "LightSnow",
    "230": "HeavySnow",
    "248": "Fog",
    "260": "Fog",
    "263": "LightShowers",
    "266": "LightRain",
    "281": "LightSleet",
    "284": "LightSleet",
    "293": "LightRain",
    "296": "LightRain",
    "299": "HeavyShowers",
    "302": "HeavyRain",
    "305": "HeavyShowers",
    "308": "HeavyRain",
    "311": "LightSleet",
    "314": "LightSleet",
    "317": "LightSleet",
    "320": "LightSnow",
    "323": "LightSnowShowers",
    "326": "LightSnowShowers",
    "329": "HeavySnow",
    "332": "HeavySnow",
    "335": "HeavySnowShowers",
    "338": "HeavySnow",
    "350": "LightSleet",
    "353": "LightShowers",
    "356": "HeavyShowers",
    "359": "HeavyRain",
    "362": "LightSleetShowers",
    "365": "LightSleetShowers",
    "368": "LightSnowShowers",
    "371": "HeavySnowShowers",
    "374": "LightSleetShowers",
    "377": "LightSleet",
    "386": "ThunderyShowers",
    "389": "ThunderyHeavyRain",
    "392": "ThunderySnowShowers",
    "395": "HeavySnowShowers",
}


def format_time(string):
    """Format tooltip hour number."""
    return string.replace("00", "").zfill(2)


def format_temp(string):
    """Format tooltip temperature number."""
    return (string + "°").ljust(3)


def format_chances(hour):
    """Format tooltip possible conditions string."""
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    return "".join(f", {chance} {hour[event]}%"
                   for event, chance in chances.items() if int(hour[event]))


def build_data(weather):
    """Build and format the json output for waybar to understand."""

    data = {}

    current_temp = weather['current_condition'][0]['temp_C']
    current_weather = weather['current_condition'][0]['weatherDesc'][0][
        'value']
    feels_like = weather['current_condition'][0]['FeelsLikeC']
    location_name = weather['nearest_area'][0]['areaName'][0]['value']
    wind_speed = weather['current_condition'][0]['windspeedKmph']
    humidity = weather['current_condition'][0]['humidity']

    data['text'] = current_temp + "°"
    data['alt'] = WWO_CODE[weather['current_condition'][0]['weatherCode']]

    data['tooltip'] = f"Weather in <b>{location_name}</b>:\n"
    data['tooltip'] += f"<b>{current_weather} {current_temp}°</b>\n"
    data['tooltip'] += f"Feels like: {feels_like}°\n"
    data['tooltip'] += f"Wind: {wind_speed}km/h\n"
    data['tooltip'] += f"Humidity: {humidity}%\n"

    if weather['weather'][0]['date'] != datetime.now().strftime("%Y-%m-%d"):
        weather['weather'].pop(0)

    for i, day in enumerate(weather['weather']):
        sunrise = day['astronomy'][0]['sunrise']
        sunset = day['astronomy'][0]['sunset']
        day_of_week = datetime.strptime(day['date'], "%Y-%m-%d").strftime("%A")

        data['tooltip'] += "\n<b>"
        data['tooltip'] += ["Today", "Tomorrow", day_of_week][min(i, 2)] + ", "
        data['tooltip'] += f"{day['date']}</b>\n"
        data['tooltip'] += f" {day['maxtempC']}°  {day['mintempC']}° "
        data['tooltip'] += f"  {sunrise}   {sunset}\n"
        for hour in day['hourly']:
            if not i and int(format_time(hour['time'])) < datetime.now().hour:
                continue
            data['tooltip'] += " ".join(
                map(str,
                    (format_time(hour['time']),
                     WEATHER_SYMBOL[WWO_CODE[hour['weatherCode']]],
                     format_temp(hour['tempC']),
                     hour['weatherDesc'][0]['value'], format_chances(hour))))
            data['tooltip'] += "\n"

    data['tooltip'] = data['tooltip'].rstrip()
    return data


if __name__ == "__main__":
    weather_data = requests.get("https://wttr.in/?format=j1", timeout=1).json()
    print(json.dumps(build_data(weather_data), separators=(',', ':')))
