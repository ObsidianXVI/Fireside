part of fireside;

class ToneArmWidget extends StatefulWidget {
  final void Function() toggleCallback;

  const ToneArmWidget({
    required this.toggleCallback,
    super.key,
  });

  @override
  ToneArmWidgetState createState() => ToneArmWidgetState();
}

class ToneArmWidgetState extends State<ToneArmWidget> {
  double rotAngle = -pi / 8;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform(
        transform: Matrix4.rotationZ(rotAngle),
        origin: Offset(205, 68),
        child: Container(
          // color: Colors.green,
          child: Stack(
            children: [
              Image(
                image: AssetImage('images/arm_1.png'),
              ),
              Positioned(
                top: 68,
                left: 205, //61,
                child: Container(
                  width: 10,
                  height: 10,
                  // color: Colors.amber,
                ),
              ),
              Positioned(
                top: 6,
                right: 20,
                child: Transform.rotate(
                  angle: pi / 4,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.toggleCallback();
                        rotAngle = rotAngle == -pi / 8 ? -pi / 4 : -pi / 8;
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 40,
                      color: Colors.transparent,
                      // color: Colors.pink,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//        origin: Offset(205, 68),

/**
 *   double _angle = 0.0;
  double _oldAngle = 0.0;
  double _angleDelta = 0.0;
  double rotAngle = -pi / 8;
  static const widthRatio = 70 / 276;
  static const heightRatio = 63 / 348;
 * MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Transform.rotate(
              angle: _angle,
              child: Stack(
                children: [
                  const Image(
                    image: AssetImage('images/arm_1.png'),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 265,
                    left: 5,
                    child: Container(
                      width: 90,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          //   Offset centerOfGestureDetector = Offset(
                          // constraints.maxWidth / 2, constraints.maxHeight / 2);
                          /**
                           * using center of positioned element instead to better fit the
                           * mental map of the user rotating object.
                           * (height = container height (30) + container height (30) + container height (200)) / 2
                           */

                          Offset centerOfGestureDetector = Offset(
                              constraints.maxWidth * (1 - widthRatio),
                              constraints.maxHeight * heightRatio);
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onPanStart: (details) {
                              print(details.globalPosition);
                              final touchPositionFromCenter =
                                  details.localPosition -
                                      centerOfGestureDetector;
                              _angleDelta =
                                  _oldAngle - touchPositionFromCenter.direction;
                            },
                            onPanEnd: (details) {
                              setState(
                                () => _oldAngle = _angle,
                              );
                            },
                            onPanUpdate: (details) {
                              print(details.globalPosition);
                              setState(
                                () {
                                  _angle = (details.localPosition -
                                              centerOfGestureDetector)
                                          .direction +
                                      _angleDelta;
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: 63,
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
 */