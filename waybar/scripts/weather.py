#!/usr/bin/env python
"""
Waybar weather module that uses open-meteo.com as the source.

Requires a Nerd Font with the nf-md-weather-* icons.
"""

import json

import requests

# API reference: https://open-meteo.com/en/docs
# The coordinates for latitude/longitude are for "Vancouver".
API_URL: str = 'https://api.open-meteo.com/v1/forecast?latitude=49.2497&longitude=-123.1193&hourly=temperature_2m&current_weather=true&timezone=America%2FLos_Angeles'
# Customized documentation URL: https://open-meteo.com/en/docs#latitude=49.2497&longitude=-123.1193&current_weather=true&timezone=America%2FLos_Angeles

# Font icons corresponding to WMO weather codes.
# Definitions of the codes can be found at the bottom of the open-meteo.com documentation.

# Display using the nf-md-weather-* icons.
WMO_ICONS: dict[int, tuple[str, str]] = {
    0: ('󰖔', '󰖙'),
    **dict.fromkeys((1, 2), ('󰼱', '󰖕')),
    3: ('󰖐', '󰖐'),
    **dict.fromkeys((45, 48), ('󰖑', '󰖑')),
    **dict.fromkeys((51, 53, 55, 61, 63, 65), ('󰖗', '󰖗')),
    **dict.fromkeys((56, 57, 66, 67), ('󰙿', '󰙿')),
    **dict.fromkeys((71, 73, 75, 77), ('󰖘', '󰖘')),
    **dict.fromkeys((80, 81, 82), ('󰖗', '󰼳')),
    **dict.fromkeys((85, 86), ('󰖘', '󰼴')),
    **dict.fromkeys((95, 96, 99), ('󰙾', '󰙾')),
}

# Display using the nf-weather-* icons.
# WMO_ICONS: dict[int, tuple[str, str]] = {
#     0: ('', ''),
#     1: ('', ''),
#     2: ('', ''),
#     3: ('', ''),
#     **dict.fromkeys((45, 48), ('', '')),
#     **dict.fromkeys((51, 53, 55, 61, 63, 65), ('', '')),
#     **dict.fromkeys((56, 57, 66, 67), ('', '')),
#     **dict.fromkeys((71, 73, 75, 77), ('', '')),
#     **dict.fromkeys((80, 81, 82), ('', '')),
#     **dict.fromkeys((85, 86), ('', '')),
#     **dict.fromkeys((95, 96, 99), ('', '')),
# }


def build_data(data):
    temperature_units: str = data['hourly_units']['temperature_2m']
    return {
        'text':
        '{} {:.1f}{}'.format(
            WMO_ICONS[data['current_weather']['weathercode']][data['current_weather']['is_day']],
            data['current_weather']['temperature'], temperature_units),
    }


if __name__ == '__main__':
    weather_data = requests.get(API_URL, timeout=5.0).json()
    print(json.dumps(build_data(weather_data), separators=(',', ':')))
