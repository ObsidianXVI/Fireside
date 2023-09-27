part of fireside;

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
  void initState() {
    if (FiresideState.currentTrack == null) {
      _controller.stop();
      Navigator.of(context).pushNamed('/shelf');
    } else {
      SpotifyService.playTrack(FiresideState.currentTrack!);
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                      trackImage: FiresideState.currentTrack!.image,
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
/*             Positioned(
              right: 0,
              top: 50,
              child: Transform(
                transform: Matrix4.rotationZ(-pi / 4),
                origin: const Offset(70, 63),
                child: const Image(
                  image: AssetImage('images/arm_1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
