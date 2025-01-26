import 'package:dio/dio.dart';

import 'package:test_my_skill/services/WeatherService.dart';

class ApiClient {

  final Dio _dio = Dio(BaseOptions(

    baseUrl: 'https://api.tomorrow.io/v4/weather/forecast?location=42.3478,-71.0466&apikey=e2LHShAQtS3oAb0aZkJ3wbpyXXMqAtrQ',

  ));

  //replace with your ApiKEY

  //get your key from app.tomorrow.io/development/keys

  static const String apiKey = 'e2LHShAQtS3oAb0aZkJ3wbpyXXMqAtrQ';

  //pick a location to get the weather

  static const location = [40.758, -73.9855]; //New York

  //// list the fields you want to get from the api

  static const fields = [

    "windSpeed",

    "windDirection",

    "temperature",

    "temperatureApparent",

    "weatherCode",

    "humidity",

    "visibility",

    "dewPoint",

    "cloudCover",

    "precipitationType"

  ];

  // choose the unit system, either metric or imperial

  static const units = "imperial";

  // set the timesteps, like "current" and "1d"

  static const timesteps = ["current", "1d"];

  // configure the time frame up to view the current and 4-days weather forecast

  String startTime =

  DateTime.now().toUtc().add(const Duration(minutes: 0)).toIso8601String();

  String endTime =

  DateTime.now().toUtc().add(const Duration(days: 4)).toIso8601String();

  //method to get the weather data

  Future<Weather> getWeather() async {
    try {
      final response = await _dio.get('/timelines', queryParameters: {

        'location': location.join(','),

        'apikey': apiKey,

        'fields': fields,

        'units': units,

        'timesteps': timesteps,

        'startTime': startTime,

        'endTime': endTime
      });

      //parse the JSON data, returns the Weather data

      return Weather.fromJson(response.data);
    } on DioError catch (e) {
      //returns the error if any

      return e.response!.data;
    }
  }
  static String handleWeatherCode(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return "Unknown";
      case 1000:
        return 'Clear, Sunny';
      case 1100:
        return 'Mostly Clear';
      case 1101:
        return 'Partly Cloudy';
      case 1102:
        return 'Mostly Cloudy';
      case 1001:
        return 'Cloudy';
      case 2000:
        return 'Fog';
      case 4200:
        return 'Light Rain';
      case 6200:
        return 'Light Freezing Rain';
      default:
        return 'Unknown';
    }
  }

  static String handleWeatherIcon(String weatherCodeName) {
    switch (weatherCodeName) {
      case 'Clear, Sunny':
        return "assets/images/clear.png";
      case 'Mostly Clear':
        return 'assets/images/mostly_clear.png';
      case 'Partly Cloudy':
        return 'assets/images/partly_cloudy.png';
      case 'Mostly Cloudy':
        return 'assets/images/mostly_cloudy.png';
      case 'Cloudy':
        return 'assets/images/cloudy.png';
      case 'Fog':
        return 'assets/images/fog.png';
      case 'Light Rain':
        return 'assets/images/light_rain.png';
      case 'Light Freezing Rain':
        return 'assets/images/light_freezing_rain.png';
      default:
        return '';
    }
  }
}