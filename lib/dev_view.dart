part of fireside;

class FiresideDevView extends StatefulWidget {
  const FiresideDevView({
    super.key,
  });

  createState() => FiresideDevViewState();
}

class FiresideDevViewState extends State<FiresideDevView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 12),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.green,
      child: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                width: 800,
                height: 800,
                // color: Colors.amber,
                child: Center(
                  child: RotationTransition(
                    turns: _animation,
                    child: VinylWidget(
                      trackImage:
                          Image(image: AssetImage('images/kid_cudi.jpg')),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 50,
              child: ToneArmWidget(
                toggleCallback: () {},
              ),
              /* Transform.rotate(
                angle: -pi / 8,
                child: Image(
                  image: AssetImage('images/arm_1.png'),
                  fit: BoxFit.cover,
                ),
              ), */
            ),
          ],
        ),
      ),
    );
  }
}
