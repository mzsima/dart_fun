import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() {
  runApp(MaterialApp(home: MyApp()));
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                onSubmitted: (text) { _addText(arkitController, text); },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a text',
                ),
              ),
            )
          ]),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
  }

  void _addText(ARKitController controller, String text) {
    final arText = ARKitText(
      text: text,
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(Colors.blue),
        )
      ],
    );
    final node = ARKitNode(
      geometry: arText,
      position: vector.Vector3(-0.3, 0.1, -1.4),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );
    arkitController.add(node);

    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final position = node.position;
      position.z += 0.01;
      node.position = position;
    });
  }
}
