///Import Flutter

import 'dart:async';
import 'package:appxor/src/Mxins/alerts.dart';

import 'package:appxor/src/Pages/xorService.dart';
import 'package:flutter/material.dart';

class XorBloc with Alerts {
  LoginService xorService = LoginService();
  StreamController<int> botonXorC = StreamController<int>.broadcast();
  Stream<int> get botonXorS => botonXorC.stream;

  requestLogin(context, {String? x1, String? x2}) async {
    if (x1 == null || x2 == null || x1 == "" || x2 == "") {
      showErrorDialog(context: context, textContent: "Verifique los campos.");

      return;
    }
    showLoadingDialog(context: context, text: "Cargando...");
    dynamic response = await xorService.xorS(x1: x1, x2: x2);
    Navigator.pop(context);
    if (response == null ||
        response["error"] == "could not convert string to float: ''") {
      botonXorC.sink.add(3);
      showErrorDialog(context: context, textContent: "Verifique los campos.");
    } else {
      botonXorC.sink.add(response["label"]);
      //xorModel = XorM.fromJson(response);
    }
  }

  dispose() {
    botonXorC.close();
  }
}
