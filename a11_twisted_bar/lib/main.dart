import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(MaterialApp(home: MyApp()));
}


typedef AnimateTo = double;

  class CubeTwistedTower {
    final ARKitController controller;
    final list = <ARKitNode>[];
    var num = 150;
    var l = 0.002;
    late var rect = ARKitBox(width: l, height: l, length: l);
    var rng = Random();
    var animations = <int, AnimateTo>{};

    CubeTwistedTower(this.controller) {

      for(int i = 0 ; i < num; i++) {
        var y = l * i;
        var angle = i * pi / 20.0;
        final node = ARKitNode(
          geometry: rect,
          position: vector.Vector3(0, y, -0.1),
          eulerAngles: vector.Vector3(angle, 0, 0),
        );
        controller.add(node);
        list.add(node);
      }
    }
  }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ARKitController arkitController;
  ARKitReferenceNode? node;

  Timer? timer;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('AR Playground')),
        body: Container(
          child: 
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ARKitSceneView(
                onARKitViewCreated: onARKitViewCreated,
              ),
            ),
          ]),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    CubeTwistedTower(arkitController); 
  }
}
