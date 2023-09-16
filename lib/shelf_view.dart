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
                    Row(
                      children: [
                        p.images.first,
                        Text(
                          p.name,
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                ],
              );
              print(tiles);
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
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: tiles,
        ),
      ),
    );
  }
}
