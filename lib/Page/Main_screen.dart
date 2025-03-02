import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notebook/data/DataFile.dart';
import 'package:my_notebook/models/Drawer.dart';
import 'package:weather/weather.dart';
import 'package:firebase_core/firebase_core.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
final WeatherFactory _wf = WeatherFactory(OPEN_WEATHER_API);


Weather? _weather;
  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName(city).then((value) {
      setState(() {
        _weather = value;
      });
      dataSet();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( backgroundColor: Colors.green,
        centerTitle: true,
        title: Text('Доброго дня, шановний',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: 'GreatVibes'
          ),),
        actions: [

        ],
      ),

      body: Column(
        children: [  SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
          _WeatherUI(),
        ],
      ),

      bottomSheet: Container (
          height: MediaQuery.sizeOf(context).height * 0.10,
          decoration:  BoxDecoration(color: Colors.green[100],),
      child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(onPressed: (){
            Navigator.pushReplacementNamed(context, '/Home');//Закрива стару і відкрива нову
            //Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
            // Відкрив нову поверху старої без або з можливістю повернуться
            // Navigator.pushNamed(context, '/Home');
            //Відкрива нову поверх старої з можливістю повернуться
          }, child: Text('Moї плани на сьогодні', style: TextStyle(color: Colors.black, fontSize: 20),),
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.green[300]
            ),),
        ],
      ),),

      drawer: drawer(context),

    );

  }
  Widget _WeatherUI(){
    if(_weather == null){
     return const Center(child: CircularProgressIndicator());
    }
    else{
      return SizedBox(height: MediaQuery.sizeOf(context).height * 0.06,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _DateTimeFormat(),
          _locationHeder(),
          _WeatherIcon(),
          _curretTemp(),
          _curretWind(),
          _extraInfo(),
          Padding(padding: EdgeInsets.only(top: 10))
        ],
      ),);
    }
  }

  Widget _locationHeder(){
  return TextButton( child: Text( _weather?.areaName ?? "", style: TextStyle(color: Colors.black, fontSize: 20)),
  onPressed: SitySelect,
  );
  }

  Widget _DateTimeFormat(){
    DateTime now = _weather!.date!;
    return Column(
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('${DateFormat('d.${now.month}.y').format(now)}',
          style:TextStyle(
            color: Colors.black,
            fontSize: 25,
          )
          ,),

          Padding(padding: EdgeInsets.only( right:  MediaQuery.sizeOf(context).width * 0.05,)),

          Text(DateFormat('EEEE').format(now),
              style:TextStyle(
            color: Colors.black,
            fontSize: 25,
          )),],),

      Text(DateFormat('hh:mm:ss a').format(now),
          style:TextStyle(
            color: Colors.black,
            fontSize: 25,
          )),
      ],
    );
 }

  Widget _WeatherIcon(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          Container( height: MediaQuery.sizeOf(context).height * 0.2,
            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png'),),),
          ),  
        Text(_weather?.weatherDescription ?? '',style:TextStyle(
          color: Colors.black,
          fontSize: 25,
        )),
      ],
    );
 }

  Widget _curretTemp(){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('${_weather?.temperature?.celsius?.toStringAsFixed(0)}° С',
              style:TextStyle(
                color: Colors.black,
                fontSize: 55,
              )),
        ],
      );}

  Widget _curretWind(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(' ${_weather?.windSpeed?.toStringAsFixed(1)}M/s',
            style:TextStyle(
              color: Colors.black,
              fontSize: 35,
            )),
      ],
    );}

  Widget _extraInfo(){
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
        width: MediaQuery.sizeOf(context).height * 0.6,
      decoration: BoxDecoration(color: Colors.greenAccent, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° С',
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
              Text('Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° С',
                  style:TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
          ],),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             mainAxisSize: MainAxisSize.max,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text('Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%',
                   style:TextStyle(
                     color: Colors.black,
                     fontSize: 20,
                   )),
               Text('Feel like: ${_weather?.tempFeelsLike?.celsius?.toStringAsFixed(0)}° C',
                   style:TextStyle(
                     color: Colors.black,
                     fontSize: 20,
                   )),
             ],)
         ],
      ),

    );
}

void dataSet(){
  DateTime now = _weather!.date!;
    Date = '${DateFormat('d.${now.month}.y').format(now)}';
    Time = DateFormat('hh:mm:ss a').format(now);
}
void SitySelect() {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: TextField(controller: TextEditingController(text: city),
        onChanged: (value) { city = value;},),
        actions: [TextButton(onPressed: (){Navigator.canPop(context);}, child: Text("OK",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30
          )),)],
      );

    });
}
}
