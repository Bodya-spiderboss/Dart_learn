import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_notebook/data/DataFile.dart';
import 'package:weather/weather.dart';


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
    _wf.currentWeatherByCityName('Dnipro').then((value) {
      setState(() {
        _weather = value;
      });

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

      drawer:  NavigationDrawer(

        backgroundColor: Colors.green,
        children: [

              Container(color: Colors.white,
                  height: MediaQuery.sizeOf(context).height * 0.86,
                  width: MediaQuery.sizeOf(context).width * 1 ,

                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    CircleAvatar(backgroundImage: AssetImage('packages/image/restran.jpeg'), radius: MediaQuery.sizeOf(context).height * 0.06,),
                    // margin:EdgeInsets.fromLTRB(5, 5, 15, 5) ,
                    Padding(padding: EdgeInsets.only(top: 20)),
                    TextButton(onPressed: (){Navigator.pushNamed(context, '/User');},
                      child: Text (name,style: TextStyle(fontSize: 25,color: Colors.black,)),
                    ),
                    Row(children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Icon(Icons.home_filled, size: MediaQuery.sizeOf(context).height * 0.035,),
                      TextButton (
                        style: ElevatedButton.styleFrom (
                            backgroundColor: Colors.white,
                            overlayColor: Colors.green,
                            minimumSize: Size(100, 25)
                        ),
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, '/');
                        }, child: Text('Головне меню', style: TextStyle(color: Colors.black, fontSize: 15),),
                      ),]),

                    Row(children: [
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Icon(Icons.list_alt, size: MediaQuery.sizeOf(context).height * 0.035,),
                      TextButton(
                        style: ElevatedButton.styleFrom (
                            backgroundColor: Colors.white,
                            overlayColor: Colors.green,
                            minimumSize: Size(100, 45)
                        ),
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, '/Home');
                        }, child: Text('Moї плани', style: TextStyle(color: Colors.black, fontSize: 15),),
                      ),
                    ],),

                  ],) ),
          BottomAppBar(
            color: Colors.white,
            child:
            Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings, size: MediaQuery.sizeOf(context).height * 0.035,),
                TextButton(
                  style: ElevatedButton.styleFrom (
                      overlayColor: Colors.green,
                      minimumSize: Size(100, 45)
                  ),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, '/Settings');
                  }, child: Text('Налаштування', style: TextStyle(color: Colors.black, fontSize: 15),),
                ),

              ],),
          ),
        ],

      ),

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
  return Text(_weather?.areaName ?? "", style: TextStyle(color: Colors.black, fontSize: 20),);
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

          Padding(padding: EdgeInsets.only( right:  MediaQuery.sizeOf(context).height * 0.02,)),

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
}
