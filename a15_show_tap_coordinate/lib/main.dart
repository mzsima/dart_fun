import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: MyWidget());
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String pointData = "Ready!";

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print(details.localPosition);
    setState(() {
      pointData = "tap down " + x.toString() + ", " + y.toString();
    });
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    print(details.localPosition);
    setState(() {
      pointData = "tap up " + x.toString() + ", " + y.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) => _onTapDown(details),
      onTapUp: (TapUpDetails details) => _onTapUp(details),
      behavior: HitTestBehavior.opaque,
      child: Center(
          child: Text(pointData,
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 40))),
    );
  }
}
