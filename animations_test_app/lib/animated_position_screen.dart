import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPositionScreen extends StatefulWidget {
  const AnimatedPositionScreen({Key? key}) : super(key: key);

  @override
  _AnimatedPositionScreenState createState() => _AnimatedPositionScreenState();
}

class _AnimatedPositionScreenState extends State<AnimatedPositionScreen> {
  final Duration _duration = const Duration(seconds: 1);
  final double _width = 100;
  final double _height = 100;
  final Color _color = Colors.red;
  final BorderRadius _radius = BorderRadius.circular(40);

  double _posTop=100;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AnimatedPosition"),
      ),
      body: Stack(
        children: <Widget>[
          const Center(
            child: Text(
              'You have pushed the button this many times:',
            ),
          ),
          AnimatedPositioned(
            duration: _duration,
            top: _posTop,
            right: 100,
            child: Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(color: _color, borderRadius: _radius),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Random random = Random();
            _posTop = random.nextInt(MediaQuery.of(context).size.height.toInt()).toDouble();
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
