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
    late var rect = ARKitBox(width: l, height: l, length: l);
    var rng = Random();
    var animations = <int, AnimateTo>{};

    CubeWall(this.controller) {

      for( var i = 0 ; i < num; i++) {
        var x = l * (i % 12);
        var y = 0.0; //rng.nextInt(100) * 0.0002;
        var z = l * (i / 12);
        final node = ARKitNode(
          geometry: rect,
          position: vector.Vector3(x, y, z),
          eulerAngles: vector.Vector3.zero(),
        );
        controller.add(node);
        list.add(node);
      }
    }

    void tick () {
      var index = rng.nextInt(num);
      if (!animations.containsKey(index)) {
        animations[index] = rng.nextInt(100) * 0.0002;
      }
      var removeKeys = <int>[];
      animations.forEach((key, value) {
        var position = list[key].position;
        var delta = 0.0; 
        if (position.y < value) {
          delta = 0.0002;
        } else {
          delta = -0.0002;
        }
        position.y += delta;
        list[key].position = position;

        if (delta > 0 && position.y > value || delta < 0 && position.y < value) {
          removeKeys.add(key);
        }
      });

      for (int key in removeKeys) {
        animations.remove(key);
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
    
    var wall = CubeWall(arkitController); 
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      wall.tick();
    });
  }
}
