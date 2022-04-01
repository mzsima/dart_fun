import 'package:a14_pokedex_bloc/screens/poke_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Pokedex Bloc', home: PokePage(title: 'Poke'));
  }
}
