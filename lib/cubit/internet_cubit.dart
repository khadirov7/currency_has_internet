import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCubit extends Cubit<bool> {
  final Connectivity _connectivity = Connectivity();

  InternetCubit(Connectivity connectivity) : super(true) {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        emit(false); // Internet yo'q
      } else {
        emit(true); // Internet bor
      }
    });
  }
}
