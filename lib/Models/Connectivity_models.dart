import 'dart:async';

class ConnectivityModel {
  String Connectivitystatus;
  StreamSubscription? Connectivitystream;

  ConnectivityModel ({
    required this.Connectivitystatus,
    this.Connectivitystream,
});
}