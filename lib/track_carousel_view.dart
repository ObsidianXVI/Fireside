part of fireside;

class FiresideTrackCarouselView extends StatefulWidget {
  const FiresideTrackCarouselView({super.key});
  @override
  State<StatefulWidget> createState() => FiresideTrackCarouselViewState();
}

class FiresideTrackCarouselViewState extends State<FiresideTrackCarouselView> {
  final ScrollController scrollController = FixedExtentScrollController();
  final List<Track> tracks = [];
  late final Future trackFuture = AuthService.withToken((token) async {
    if (FiresideState.currentPlaylist == null) {
      Navigator.of(context).pushNamed('/shelf');
    } else {
      tracks.addAll(await SpotifyService.getTracksInPlaylist(
          FiresideState.currentPlaylist!));
    }
  });

  Color bgColor = Colors.transparent;
  Color textColor = Colors.transparent;
  int currentIndex = 0;
  // List<Widget> tiles = [];

  @override
  void initState() {
    updateBgColorIfTrackOrPlaylist();
    super.initState();
  }

  void updateBgColorIfTrackOrPlaylist([int index = 0]) async {
    /* if (widget.items.isNotEmpty) {
      ColorScheme? colorScheme;
      if (widget.items.first is Track) {
        colorScheme = await ColorScheme.fromImageProvider(
            provider: (widget.items[index] as Track).image.image);
      } else if (widget.items.first is Playlist) {
        colorScheme = await ColorScheme.fromImageProvider(
            provider: (widget.items[index] as Track).image.image);
      }
      setState(() {
        bgColor = colorScheme!.primary;
        textColor = bgColor.lighterTone.withOpacity(0.85);
      });
    } */
  }

  Future<void> updateBackgroundColor(ImageProvider imageProvider) async {}
  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FutureBuilder(
          future: trackFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return Row(
                children: [
                  Container(
                    width: 400,
                    height: 900,
                    child: ListWheelScrollView(
                      controller: scrollController,
                      physics: const FixedExtentScrollPhysics(),
                      itemExtent: 300,
                      offAxisFraction: 1.5,
                      diameterRatio: 4.4,
                      onSelectedItemChanged: (index) async {
                        currentIndex = index;
                        updateBgColorIfTrackOrPlaylist(index);
                      },
                      children: [
                        for (final track in tracks) TrackItem(track: track)
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 750,
                    height: 900,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 100,
                        top: 100,
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          tracks[currentIndex].name,
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
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
