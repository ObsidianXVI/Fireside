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
  late Track currentTrack;
  Color bgColor = Colors.transparent;
  Color textColor = Colors.transparent;

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
      currentTrack = FiresideState.currentTrack!;
      ColorScheme.fromImageProvider(provider: currentTrack.image.image)
          .then((ColorScheme colorScheme) {
        setState(() {
          bgColor = colorScheme.primary;
          textColor = bgColor.lighterTone.withOpacity(0.85);
          print(textColor);
          print(bgColor);
        });
      });
      SpotifyService.playTrack(currentTrack);
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
      color: bgColor,
      child: Center(
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 20,
              child: Text(
                currentTrack.name,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                width: 800,
                height: 800,
                child: Center(
                  child: RotationTransition(
                    turns: _animation,
                    child: VinylWidget(
                      trackImage: currentTrack.image,
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

extension ColorUtils on Color {
  Color get lighterTone =>
      Color(value).withGreen(green + 40).withBlue(blue + 40);
}
