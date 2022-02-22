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

  class CubeWall {
    final ARKitController controller;
    final list = <ARKitNode>[];
    var num = 144;
    var l = 0.02;
    late var rect = ARKitBox(width: l* 1.05, height: l * 1.05, length: l * 1.05);
    var rng = Random();
    var animations = <int, AnimateTo>{};

    CubeWall(this.controller) {

      for(int i = 0 ; i < num; i++) {
        var x = 1.41 * l * (i % 12);
        int n = (i / 12).floor();
        if (n.isEven) {
          x = x + l * 0.705;
        }
        var y = -(l * 0.69) * n;
        var z = (l * 0.97) * n;
        final node = ARKitNode(
          geometry: rect,
          position: vector.Vector3(x, y, z),
          eulerAngles: vector.Vector3(pi / 4.0, 0, 0),
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
        appBar: AppBar(title: const Text('Coming Text')),
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
    CubeWall(arkitController); 
  }
}
