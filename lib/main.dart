import 'package:dio/dio.dart';
import 'package:AppMock/view/home/OptionView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:toast/toast.dart';

import 'Net.dart';

var client = http.Client();

void main() {
  runApp(MyApp());
  listen();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  var test;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('App Mock'),
        ),
        body: Center(
          child: Column(
            children: [
              OptionView(),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    // test = httpTest(context);
                  },
                  child: Text("${123}"),
                ),
              ),
              FutureBuilder(
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      // 请求失败，显示错误
                      return Text("Error: ${snapshot.error}");
                    } else {
                      // 请求成功，显示数据
                      return Text("${snapshot.data}");
                    }
                  } else {
                    // 请求未结束，显示loading
                    return CircularProgressIndicator();
                  }
                },
                future: httpTest(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
