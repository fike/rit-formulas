# -*- coding: utf-8 -*-

# Copyright 2020 Fernando Ike
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

import requests
import json
from colorama import Fore
from colorama import Style


def owm_get(city, token):
    url = "https://api.openweathermap.org/data/2.5/weather/"
    payload = {'q': city, 'appid': token, 'units': 'metric'}
    try:
        resp = requests.get(url, params=payload, timeout=10)
        resp.raise_for_status()
    except requests.exceptions.Timeout:
        print("Retrying connection")
        resp = requests.get(url, params=payload)
    except requests.exceptions.HTTPError as err:
        print("Fail to get city weather", err)
        raise SystemExit()

    city_data = json.loads(resp.content)
    city_temp = city_data['main']['temp']
    city_environment = city_data['weather'][0]['main']
    city_weather = {'city': city,
                    'weather': city_environment, 'temperature': city_temp}
    return city_weather


def Run(city, token):
    response = owm_get(city, token)
    FGREEN = "\033[1;32;40m"
    FRED = "\033[1;35;40m"
    FENDC = '\033[m'
    city_name = response['city']
    city_weather = response['weather']
    city_temperature = response['temperature']
    print("\nThe forecast weather in " + FGREEN + city_name + FENDC + " is " + FGREEN +
          city_weather + FENDC + " amd temperature is " + FGREEN + str(city_temperature) + FENDC + ".")

    print( "\nData provider by " + FRED  + " OpenWeatherMap" + FENDC + ".\n")
