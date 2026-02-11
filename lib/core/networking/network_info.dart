// import 'package:connectivity_plus/connectivity_plus.dart';
//
//
// abstract class NetworkInfo {
//   Future<bool> get isConnected;
//
//   Stream<List<ConnectivityResult>> get onConnectivityChanged;
// }
//
//
// class NetworkInfoImpl implements NetworkInfo {
//   final Connectivity _connectivity;
//
//   const NetworkInfoImpl(this._connectivity);
//
//   @override
//   Future<bool> get isConnected async {
//     final result = await _connectivity.checkConnectivity();
//     return _isConnected(result);
//   }
//
//   @override
//   Stream<List<ConnectivityResult>> get onConnectivityChanged =>
//       _connectivity.onConnectivityChanged;
//
//   bool _isConnected(List<ConnectivityResult> results) {
//     return results.any((result) =>
//         result == ConnectivityResult.wifi ||
//         result == ConnectivityResult.mobile ||
//         result == ConnectivityResult.ethernet ||
//         result == ConnectivityResult.vpn);
//   }
// }
//
