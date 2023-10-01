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
  final FocusNode focusNode = FocusNode();
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
      child: KeyboardListener(
        autofocus: true,
        focusNode: focusNode,
        onKeyEvent: (KeyEvent keyEvent) async {
          if (keyEvent.logicalKey == LogicalKeyboardKey.space) {
            await showDialog(
              context: context,
              builder: (_) => playbackControlsBuilder(
                _,
                primary: bgColor,
                accent: textColor,
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
                      child: Text(
                        currentTrack.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: textColor,
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
            color: primary.withOpacity(0.6),
            border: Border.all(color: primary),
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
                    callback: () {
                      SpotifyService.skipToPrevious();
                    },
                  ),
                  const SizedBox(width: 20),
                  PlaybackControlButton(
                    primary: primary,
                    accent: accent,
                    iconData: Icons.pause_circle,
                    callback: () {
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
                  const SizedBox(width: 20),
                  PlaybackControlButton(
                    primary: primary,
                    accent: accent,
                    iconData: Icons.skip_next,
                    callback: () {
                      SpotifyService.skipToNext();
                    },
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

extension ColorUtils on Color {
  Color get lighterTone =>
      Color(value).withGreen(green + 40).withBlue(blue + 40);
}

class PlaybackControlButton extends StatefulWidget {
  final Color accent;
  final Color primary;
  final IconData iconData;
  final void Function() callback;

  const PlaybackControlButton({
    required this.accent,
    required this.primary,
    required this.iconData,
    required this.callback,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => PlaybackControlButtonState();
}

class PlaybackControlButtonState extends State<PlaybackControlButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => hover = true),
        onExit: (_) => setState(() => hover = false),
        child: GestureDetector(
          onTap: widget.callback,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: widget.primary.withOpacity(0.6),
              border: Border.all(color: widget.primary),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                widget.iconData,
                size: 75,
                color: hover ? widget.accent : widget.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
