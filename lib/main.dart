library fireside;

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const FiresideApp());
}

class FiresideApp extends StatelessWidget {
  const FiresideApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fireside',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/player',
      routes: {
        '/player': (_) => FiresidePlayer(),
      },
    );
  }
}

class FiresidePlayer extends StatefulWidget {
  const FiresidePlayer({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => FiresidePlayerState();
}

class FiresidePlayerState extends State<FiresidePlayer>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 12),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.green,
      child: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                width: 800,
                height: 800,
                color: Colors.amber,
                child: Center(
                  child: RotationTransition(
                    turns: _animation,
                    child: Image(
                      image: AssetImage('images/vinyl_1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 50,
              child: Transform.rotate(
                angle: -pi / 4,
                child: Image(
                  image: AssetImage('images/arm_1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
