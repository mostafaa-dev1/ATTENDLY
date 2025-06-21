import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
 static Future<bool> checkConnctivity() async {
    final List<ConnectivityResult> result =
        await (Connectivity().checkConnectivity());
    if (result.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (result.contains(ConnectivityResult.wifi)) {
      return true;
    } else {
      return false;
    }
  }
}
