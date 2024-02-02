part of fireside;

class FiresideShelfView extends StatefulWidget {
  const FiresideShelfView({super.key});

  @override
  State<StatefulWidget> createState() => FiresideShelfViewState();
}

class FiresideShelfViewState extends State<FiresideShelfView> {
  final ScrollController scrollController = FixedExtentScrollController();
  final List<Playlist> playlists = [];
  late final Future playlistFuture = AuthService.withToken((token) async {
    playlists.addAll(await SpotifyService.getPlaylists());
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amber,
      child: Align(
        alignment: Alignment.centerLeft,
        child: FutureBuilder(
          future: playlistFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting) {
              return Container(
                width: 1200,
                height: 900,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    for (final playlist in playlists)
                      ShelfItem(playlist: playlist)
                  ],
                ),
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
