
import 'package:flutter/material.dart';
import '../models/APIdata.dart';
import '../services/WeatherService.dart';

class HomePageState extends StatefulWidget {
  const HomePageState({super.key});

  @override
  State<HomePageState> createState() => HomePageStateState();
}

class HomePageStateState extends State<HomePageState> {
  final ApiClient _apiClient = ApiClient(); //initialize the ApiClient

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,

        body: SafeArea(

            child: FutureBuilder<Weather>(     //<<-- FutureBuilder

                future: _apiClient.getWeather(),

                builder: (context, snapshot) {
                  //loading state

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(

                      child: CircularProgressIndicator(),

                    );
                  } else {

                  //when the future is complete and there is an error, display it.

                  if (snapshot.hasError) {
                    return Center(

                      child: Text(

                        'Error: ${snapshot.error}',

                        style: const TextStyle(color: Colors.red),

                      ),

                    );
                  } else {

    //when the future is complete and has no error, show the weather.

    //get weatherCode

    int weatherCode = snapshot

        .data!.data.timelines[0].intervals[0].values.weatherCode;

    //get weatherName

    String weatherCodeName = ApiClient.handleWeatherCode(weatherCode);


    //get weatherIcon

    String weatherCodeIcon = ApiClient.handleWeatherIcon(weatherCodeName);


    return Stack(

    children: [

    //...

    Padding(

    padding: const EdgeInsets.symmetric(

    vertical: 15,

    horizontal: 15.0,

    ),

    child: ListView(

    shrinkWrap: true,

    children: [

    const Text('Current Weather',

    style: TextStyle(

    color: Colors.black,

    fontSize: 30.0,

    fontWeight: FontWeight.w700,

    )),

    const SizedBox(height: 30.0),

    Image.asset(

    weatherCodeIcon, //weatherIcon

    width: 150,

    height: 150,

    ),

    Center(

    child: RichText(

    text: TextSpan(

    //accessing the temperature value from the snapshot

    text: snapshot.data!.data.timelines[0]
        .intervals[0].values.temperature

        .toStringAsFixed(0)

        .toString(),

    style: const TextStyle(

    fontFamily: 'Raleway',

    fontSize: 144,

    color: Colors.black,

    fontWeight: FontWeight.w500),

    children: const [

    TextSpan(

    text: '°F',

    style: TextStyle(

    fontFamily: 'Raleway',

    fontSize: 48,

    color: Colors.black,

    fontWeight: FontWeight.w500,

    ),

    )

    ],

    ),

    ),
    ),
    ])
    )
    ]);

                  }
                  }
                })
        )
    );
  }
}
