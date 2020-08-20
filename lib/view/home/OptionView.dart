import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../Net.dart';

/// option view of home page
class OptionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HomeOptionIcon("images/icon_qrcode.png", () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.NO_HEADER,
            body: Column(
              children: [
                Text("扫描二维码连接mock"),
                QrImage(
                  data: "qr code test",
                  size: 150,
                )
              ],
            ),
          )..show();
        }),
        HomeOptionIcon("images/icon_proxy.png", () {
          // httpTest(context);
        }),
        HomeOptionIcon("images/icon_settings.png", () {
          Toast.show("click settings", context);
        }),
      ],
    );
  }
}

class HomeOptionIcon extends StatelessWidget {
  final String iconUrl;
  final Function callback;
  HomeOptionIcon(this.iconUrl, this.callback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image(
        image: AssetImage(iconUrl),
        width: 40,
        height: 40,
      ),
      onTap: () {
        callback();
      },
    );
  }
}
