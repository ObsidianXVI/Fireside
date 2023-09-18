part of fireside;

class FiresideShelfView extends StatefulWidget {
  final bool showPlaylists;
  final Playlist? playlist;

  const FiresideShelfView({
    required this.showPlaylists,
    this.playlist,
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
        if (widget.showPlaylists) {
          SpotifyService.getPlaylists().then((List<Playlist> playlists) {
            setState(() {
              tiles.addAll(
                [
                  for (Playlist p in playlists)
                    Container(
                      width: 200,
                      height: 200,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            tiles
                              ..clear()
                              ..addAll([
                                for (Track t in p.tracks)
                                  GestureDetector(
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
                              ]);
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
/*           SpotifyService.getTracksIn(widget.playlist!)
              .then((List<Track> tracks) {
            setState(() {
              tiles.addAll(
                [for (Track t in tracks) const Text('trackName')],
              );
            });
          }); */
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
