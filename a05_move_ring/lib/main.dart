import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ARKitController arkitController;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('ARKit in Flutter')),
      body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    final sphere = ARKitSphere(
      radius: 0.01,
    );

    final list = <ARKitNode>[];

    for( var i = 0 ; i < 12; i++) { 
      var deg = i * pi / 6.0;
      var x = sin(deg);
      var y = cos(deg) - 1;
      final node = ARKitNode(
        geometry: sphere,
        position: Vector3(x * 0.1, y * 0.1, -0.5),
        eulerAngles: Vector3.zero(),
      );
      this.arkitController.add(node);
      list.add(node);
    }

    var count = 0;
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      for( var i = 0 ; i < 12; i++) { 
        var deg = i * (pi / 6.0) + count * 0.1;
        var x = sin(deg);
        var y = cos(deg) - 5;
        final position = list[i].position;
        position.x = x * 0.1;
        position.y = y * 0.1;
        list[i].position = position;
      }
      count += 1;
      count = count % 10000;
    });
  }


      //   final rotation = node.eulerAngles;
    //   rotation.x += 0.01;
    //   node.eulerAngles = rotation;
}