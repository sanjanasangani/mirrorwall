import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../Models/Connectivity_models.dart';

class ConnectivityProvider extends ChangeNotifier {

  Connectivity connectivity = Connectivity();

  ConnectivityModel connectivityModel = ConnectivityModel(Connectivitystatus: "Waiting");

  void checkInternetConnectivity() {
      connectivityModel.Connectivitystream = connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) {
        switch(connectivityResult) {
          case ConnectivityResult.wifi:
            connectivityModel.Connectivitystatus = "wifi";
            notifyListeners();
            break;
          case ConnectivityResult.mobile:
            connectivityModel.Connectivitystatus = "Mobile Data";
            notifyListeners();
            break;
          default:
            connectivityModel.Connectivitystatus = "Waiting";
            notifyListeners();
            break;

        }
      });
  }
}