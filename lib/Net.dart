import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:dio/dio.dart';

listen() {
  HttpServer.bind(InternetAddress.loopbackIPv4, 9997).then((server) => {
        print("代理http ${server.address}:${server.port}"),
        server.listen((request) {
          //监听端口，拦截请求
          reGet(request);
        }),
      });
}

reGet(HttpRequest request) async {
  var dio = Dio();
  var response = await dio.get(request.uri.toString());
  request.response
    ..headers.contentType = ContentType("text", "plain", charset: "utf-8")
    //把接口返回数据塞回去，返回给客户端
    ..write("${response.data}")
    ..close();
  // print("reGet is:${response.data}");
}

Future<String> httpTest(BuildContext context) async {
  var url = "https://api.apiopen.top/getJoke?page=1&count=2&type=video";
  BaseOptions option = BaseOptions(connectTimeout: 2000);
  var dio = Dio(option);

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    //设置代理
    client.findProxy = (uri) {
      return HttpClient.findProxyFromEnvironment(uri, environment: {
        "http_proxy": 'http://127.0.0.1:9997',
      });
    };
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
  };

  var response = await dio.get(url);
  print("return is:${response.data}");
  return response.data.toString();
}
