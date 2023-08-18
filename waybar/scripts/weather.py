#!/usr/bin/env python
"""
Waybar weather module that uses open-meteo.com as the source.

Requires a Nerd Font with the nf-md-weather-* icons.
"""

import json
from datetime import datetime

import requests

# API reference: https://open-meteo.com/en/docs
# The coordinates for latitude/longitude, as well as the time zone, are for Vancouver, Canada.
API_URL = 'https://api.open-meteo.com/v1/forecast?latitude=49.25&longitude=-123.12&hourly=temperature_2m,precipitation_probability,precipitation,weathercode,cloudcover,windspeed_10m,windgusts_10m,uv_index,is_day&daily=sunrise,sunset&current_weather=true&timeformat=unixtime&timezone=America%2FLos_Angeles'

# Font icons corresponding to WMO weather codes.
# Definitions of the codes can be found at the bottom of the open-meteo.com documentation.

# Display using the nf-md-weather-* icons.
WMO_ICONS: dict[int, tuple[str, str]] = {
    0: ('󰖔', '󰖙'),
    **dict.fromkeys((1, 2), ('󰼱', '󰖕')),
    3: ('󰖐', '󰖐'),
    **dict.fromkeys((45, 48), ('󰖑', '󰖑')),
    **dict.fromkeys((51, 53, 55, 61, 63, 65), ('󰖖', '󰖖')),
    **dict.fromkeys((56, 57, 66, 67), ('󰙿', '󰙿')),
    **dict.fromkeys((71, 73, 75, 77), ('󰼶', '󰼶')),
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


def _get_day_string(weather: dict, day: datetime) -> str:
    current_time = datetime.fromtimestamp(weather['current_weather']['time'])
    current_days = (current_time - datetime(1970, 1, 1)).days

    match (day - datetime(1970, 1, 1)).days - current_days:
        case 0:
            return 'Today'
        case 1:
            return 'Tomorrow'
        case _:
            return day.strftime('%A')


def _build_detailed(weather: dict, index: int) -> str:
    current_time = datetime.fromtimestamp(weather['current_weather']['time'])
    this_day = datetime.fromtimestamp(weather['daily']['time'][index])

    data = '<b>' + ' ' * 10 + _get_day_string(weather, this_day).center(40) + '</b>'
    data += ' ' + datetime.fromtimestamp(weather['daily']['sunrise'][index]).strftime('%H:%M ')
    data += ' ' + datetime.fromtimestamp(weather['daily']['sunset'][index]).strftime('%H:%M\n')

    fields = (
        ('TEMP', 'temperature_2m', 5),
        ('UV', 'uv_index', 2),
        ('CLOUD', 'cloudcover', 5),
        ('POP', 'precipitation_probability', 4),
        ('PRECIP', 'precipitation', 6),
        ('WIND', 'windspeed_10m', 6),
        ('GUST', 'windgusts_10m', 6),
    )

    border = '━┯━'.join('━' * length for _, _, length in fields)
    data += '         ┏━' + border + '━┓\n'

    legend = ' │ '.join(f' {name}'[-length:].center(length) for name, _, length in fields)
    data += '┏━━━━┯━━━┩ ' + legend + ' ┃\n'

    hourly, units = weather['hourly'], weather['hourly_units']
    for i, timestamp in enumerate(map(datetime.fromtimestamp, hourly['time'])):
        if timestamp.day != this_day.day or timestamp.hour % 2 or (timestamp <= current_time):
            continue

        start = timestamp.strftime('%H │ ')
        start += WMO_ICONS[hourly['weathercode'][i]][hourly['is_day'][i]]

        line = [start]
        for _, field, length in fields:
            line.append(f'{hourly[field][i]:.0f}{units[field]}'.rjust(length))

        data += '┃ ' + ' │ '.join(line) + ' ┃\n'

    border = '━┷━'.join('━' * length for _, _, length in fields)
    data += '┗━━━━┷━━━┷━' + border + '━┛\n'

    return data


def _build_summary(weather: dict, index: int) -> str:
    return ''


def build_data(weather: dict) -> dict:
    current_weather: dict = weather['current_weather']
    temperature_units: str = weather['hourly_units']['temperature_2m']

    data = {
        'text':
        '{} {:.1f}{}'.format(WMO_ICONS[current_weather['weathercode']][current_weather['is_day']],
                             current_weather['temperature'], temperature_units),
        'tooltip':
        '',
    }

    current_time = datetime.fromtimestamp(current_weather['time'])
    details_start = current_time.hour >= 24 - 2
    details_end = 2 + (current_time.hour >= 18)

    for i in range(details_start, details_end):
        data['tooltip'] += _build_detailed(weather, i) + '\n'
    for i in range(details_end, 7):
        data['tooltip'] += _build_summary(weather, i) + '\n'

    data['tooltip'] = data['tooltip'].rstrip()

    return data


if __name__ == '__main__':
    weather_data = requests.get(API_URL, timeout=5.0).json()
    print(json.dumps(build_data(weather_data), separators=(',', ':')))
