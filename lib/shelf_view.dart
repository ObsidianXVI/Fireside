part of fireside;

class FiresideShelfView extends StatefulWidget {
  final List<Widget>? items;

  const FiresideShelfView({
    required this.items,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => FiresideShelfViewState();
}

class FiresideShelfViewState extends State<FiresideShelfView> {
  List<Widget> tiles = [];

  @override
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
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: tiles,
          ),
        ),
      ),
    );
  }
}
