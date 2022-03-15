import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'couter_observer.dart';

void main() {
  BlocOverrides.runZoned(() => 
    runApp(const CounterApp()),
    blocObserver: CounterObserver(),
  );
}