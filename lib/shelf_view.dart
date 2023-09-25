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
                    Container(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                        onTap: () async {
                          final List<Track> tracks =
                              await SpotifyService.getTracksInPlaylist(p.id);

                          setState(() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return FiresideShelfView(
                                    items: [
                                      for (Track t in tracks)
                                        GestureDetector(
                                          onTap: () {
                                            FiresideState.currentTrack = t;
                                            Navigator.of(context)
                                                .pushNamed('/player');
                                          },
                                          child: Container(
                                            width: 200,
                                            height: 200,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  width: 200,
                                                  height: 200,
                                                  child: t.image,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 10,
                                                  child: Text(
                                                    t.name,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            );
                          });
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              width: 200,
                              height: 200,
                              child: p.image,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 10,
                              child: Text(
                                p.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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
