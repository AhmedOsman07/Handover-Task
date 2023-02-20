
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MainBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('${bloc.runtimeType} $change', name: "MainBlocObserver OnChange");
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('${bloc.runtimeType} $error $stackTrace', name: "MainBlocObserver OnError");
    super.onError(bloc, error, stackTrace);
  }
}
