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
      color: Colors.purple,
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          child: Align(
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  right: 300,
                  width: 700,
                  height: 650,
                  child: Container(
                    width: 700,
                    height: 650,
                    child: const Text(
                      'The Void',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.pink,
                        fontWeight: FontWeight.w800,
                        fontSize: 200,
                        height: 0.8,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Container(
                          width: 800,
                          height: 800,
                          child: Center(
                            child: RotationTransition(
                              turns: _animation,
                              child: VinylWidget(
                                trackImage: Image.asset('images/kid_cudi.jpg'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 50,
                        child: ToneArmWidget(
                          toggleCallback: () {
                            setState(() {
                              if (_controller.isAnimating) {
                                SpotifyService.pausePlayback();
                                _controller.stop();
                              } else {
                                SpotifyService.resumePlayback();
                                _controller.repeat();
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
