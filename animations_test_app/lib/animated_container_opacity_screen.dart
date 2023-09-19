import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerOpacityScreen extends StatefulWidget {
  const AnimatedContainerOpacityScreen({Key? key}) : super(key: key);

  @override
  _AnimatedContainerOpacityScreenState createState() =>
      _AnimatedContainerOpacityScreenState();
}

class _AnimatedContainerOpacityScreenState
    extends State<AnimatedContainerOpacityScreen> {
  final Duration _duration = const Duration(seconds: 1);
  double _width = 50.0;
  double _height = 50.0;
  Color _color = Colors.red;
  bool _visible = false;
  BorderRadius _radius = BorderRadius.circular(20);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AnimatedContainer And AnimatedOpacity"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: _duration,
              width: _width,
              height: _height,
              decoration: BoxDecoration(color: _color, borderRadius: _radius),
            ),
            AnimatedOpacity(
              duration: _duration,
              opacity: _visible ? 1 : 0,
              child: const Text(
                'You have pushed the button this many times:',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Random random = Random();
            _visible = !_visible;
            _radius = BorderRadius.circular(random.nextInt(150).toDouble());
            _height = random.nextInt(300).toDouble();
            _width = random.nextInt(300).toDouble();
            _color = Color.fromRGBO(random.nextInt(250), random.nextInt(250),
                random.nextInt(250), _visible ? 0 : 1);
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
