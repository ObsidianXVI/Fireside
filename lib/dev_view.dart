part of fireside;

class FiresideDevView extends StatefulWidget {
  const FiresideDevView({
    super.key,
  });

  createState() => FiresideDevViewState();
}

class FiresideDevViewState extends State<FiresideDevView>
    with SingleTickerProviderStateMixin {
  final FocusNode focusNode = FocusNode();
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
      child: KeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKeyEvent: (KeyEvent keyEvent) async {
          if (keyEvent.logicalKey == LogicalKeyboardKey.space) {
            await showDialog(
              context: context,
              builder: (_) => playbackControlsBuilder(
                _,
                primary: Colors.purple,
                accent: Colors.pink,
              ),
              barrierDismissible: true,
            );
          }
        },
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
                                  trackImage:
                                      Image.asset('images/kid_cudi.jpg'),
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
      ),
    );
  }

  Widget playbackControlsBuilder(
    BuildContext context, {
    required Color primary,
    required Color accent,
  }) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 400,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.purple.withOpacity(0.6),
            border: Border.all(color: Colors.purple),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlaybackControlButton(
                    primary: primary,
                    accent: accent,
                    iconData: Icons.skip_previous,
                    callback: () {},
                  ),
                  const SizedBox(width: 20),
                  PlaybackControlButton(
                    primary: primary,
                    accent: accent,
                    iconData: Icons.pause_circle,
                    callback: () {},
                  ),
                  const SizedBox(width: 20),
                  PlaybackControlButton(
                    primary: primary,
                    accent: accent,
                    iconData: Icons.skip_next,
                    callback: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
