part of fireside;

class FiresideShelfView<T extends SpotifyObject> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T) createWidget;
  late final List<Widget> children = [
    for (final T item in items) createWidget(item)
  ];

  FiresideShelfView({
    required this.items,
    required this.createWidget,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => FiresideShelfViewState<T>();
}

class FiresideShelfViewState<T extends SpotifyObject>
    extends State<FiresideShelfView<T>> {
  final ScrollController scrollController = FixedExtentScrollController();
  Color bgColor = Colors.transparent;
  Color textColor = Colors.transparent;
  int currentIndex = 0;
  // List<Widget> tiles = [];

/*   @override
  void initState() {
    AuthService.withToken(
      (String token) async {
        if (widget.items == null) {
          SpotifyService.getPlaylists().then((List<Playlist> playlists) {
            setState(() {
              tiles.addAll(
                [
                  for (Playlist p in playlists)
                    GestureDetector(
                      onTap: () async {
                        final List<Track> tracks =
                            await SpotifyService.getTracksInPlaylist(p);

                        setState(() {
                          FiresideState.currentPlaylist = p;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return FiresideShelfView(
                                  items: [
                                    for (Track t in tracks)
                                      RecordSleeveWidget(
                                        track: t,
                                        callback: () {
                                          FiresideState.currentTrack = t;
                                          Navigator.of(context)
                                              .pushNamed('/player');
                                        },
                                      ),
                                  ],
                                );
                              },
                            ),
                          );
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: p.image.image),
                        ),
                      ),
                    ),
                ],
              );
            });
          });
        } else {
          tiles.addAll(widget.items!);
        }
      },
      context,
    );
    super.initState();
  } */

  @override
  void initState() {
    updateBgColorIfTrackOrPlaylist();
    super.initState();
  }

  void updateBgColorIfTrackOrPlaylist([int index = 0]) async {
    if (widget.items.isNotEmpty) {
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
    }
  }

  Future<void> updateBackgroundColor(ImageProvider imageProvider) async {}

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
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
                children: widget.children,
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
                    widget.items[currentIndex].name,
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
        ),
      ),
    );
  }
}
