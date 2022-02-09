import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(MaterialApp(home: MyApp()));
}

  class Ring {
    final rect = ARKitBox(width: 0.01, height: 0.01, length: 0.01);
    final ARKitController controller;
    final double radius;
    final bool clockwise;
    final list = <ARKitNode>[];
    final num = 50;
    var count = 0;

    Ring(this.controller, this.radius, {this.clockwise = true}) {
      for( var i = 0 ; i < num; i++) { 
        var deg = i * 2 * pi / num;
        var x = radius * sin(deg);
        var z = radius * cos(deg);
        final node = ARKitNode(
          geometry: rect,
          position: vector.Vector3(x, 0, z),
          eulerAngles: vector.Vector3.zero(),
        );
        controller.add(node);
        list.add(node);
      }
    }

    void tick () {
      for( var i = 0 ; i < num; i++) { 
        var deg = i * (2 * pi / num) + (clockwise ? count : -count) * 0.01;
        var x = radius * sin(deg);
        var z = radius * cos(deg);
        final position = list[i].position;
        position.x = x ;
        position.z = z ;
        list[i].position = position;
      }
      count += 1;
      count = count % 10000;
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
    
    var rings = <Ring>[];
    for (var i=0; i<5; i++) {
      Ring ring = Ring(arkitController, 0.20 + i * 0.04, clockwise: i % 2 == 0);
      rings.add(ring);
    }

    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      for (var ring in rings) {
        ring.tick();
      }
    });
  }
}
