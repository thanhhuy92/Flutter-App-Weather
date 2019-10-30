import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'package:flutter_appweather/Models/WeatherModels.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Sử dụng hàm bất đồng bộ
// https://dart.dev/codelabs/async-await
Future<WeatherModel> getWeather(String lat, String lng) async{

  //lấy dữ liệu API bằng http
  final reponse= await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=06ccac2af34c3e92791d3d0cc000704e&units=metric');

  if(reponse.statusCode == 200){
    var result = json.decode(reponse.body);
    var model = WeatherModel.fromJson(result);
    return model;
  }
  else
    throw Exception('Failed to load Weather Information');
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'Weather App',
        //theme: ThemeData.light(),
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Weahter App'),
            ),
            body: Container(
              // Cách xây dựng FutureBuilder xem tại đây https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
              child: FutureBuilder<WeatherModel>(
                future: getWeather('12.25', '109.18'),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    WeatherModel model = snapshot.data;
                    // định dạng thời gian
                    var fm = new DateFormat('h:mm');
                    var fm_date = new DateFormat('d MMM yyy');
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 500,
                          height: 380,
                          color: Colors.green,
                          child: Column(
                            children: <Widget>[
                              // Tên địa điểm
                              Text('${model.name}',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              // Hình ảnh lấy trên trang https://openweathermap.org
                              Image.network('https://openweathermap.org/img/wn/${model.weather[0].icon}@2x.png'),

                              // Nhiệt độ
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text('${model.main.temp}°C',
                                  style: TextStyle(
                                    fontSize: 100.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              // Thời gian (giờ hiện hành)
                              Padding(
                                padding: const EdgeInsets.only(top: 35.0),
                                child: Text('${fm.format(new DateTime.fromMillisecondsSinceEpoch((model.dt*1000), isUtc: false))}',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight:  FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              // Thời gian ( ngày, tháng , năm hiện hành)
                              Text('${fm_date.format(new DateTime.fromMillisecondsSinceEpoch((model.dt*1000),isUtc: false))}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tốc độ gió
                        Container(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('Wind (Speed/Deg):',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  Expanded(
                                    child:Text('${model.wind.speed}(m/s)/${model.wind.deg}',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Pressure: ',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  Expanded(
                                    child: Text('${model.main.pressure} hpa',
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          decoration: TextDecoration.none),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text('Humidity: ',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  Expanded(
                                    child:  Text('${model.main.humidity}%',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text('GeoCode: ',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  Expanded(
                                    child: Text('[${model.coord.lat}/${model.coord.lon}]',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        decoration: TextDecoration.none,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Tạo nút thoát app
                        Container(
                          width: 140,
                          height: 60,
                          padding: const EdgeInsets.only(top: 10.0),
                          child: RaisedButton(
                              child: Text('CANCEL',style: TextStyle(fontSize: 20.0),),
                              onPressed: (){
                                showAlertDialog(context);
                              }),
                        ),
                      ],
                    );
                  }
                  else if(snapshot.hasError)
                    return Text('${snapshot.error}',style: TextStyle(fontSize: 30.0,color: Colors.red),);
                  return CircularProgressIndicator();//default show loading
                },
              )
            ),
        ),
    );
  }

  // Sử dụng bảng thông báo (alertdialog) hỏi người sử dụng có chắc chắn thoát hay không
  void showAlertDialog(BuildContext context){
    var alertDialog = new AlertDialog(
      title: Text('Information'),
      content: Text('Do you want to exit?'),
      actions: <Widget>[
        RaisedButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('No')
          ,),
        RaisedButton(
          onPressed: (){
            SystemNavigator.pop();
          },
          child: Text('Yes'),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        });
  }
}
