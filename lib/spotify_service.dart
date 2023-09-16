part of fireside;

class SpotifyService {
  static Future<List<Playlist>> getPlaylists() async {
    return await AuthService.withToken<List<Playlist>>((String token) async {
      final List<Playlist> playlists = [];
      final Map res = jsonDecode((await get(
        Uri.https('api.spotify.com', '/v1/users/$username/playlists'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ))
          .body);
      for (Map item in res['items']) {
        playlists.add(
          Playlist(
            id: item['id'],
            images: [
              for (Map img in item['images'])
                Image.network(
                  img['url'],
                  width: img['width'],
                  height: img['height'],
                )
            ],
            description: item['description'],
            name: item['name'],
            tracksCount: item['tracks']['total'],
          ),
        );
      }
      return playlists;
    });
  }

  //static Future<List<Track>> getTracksIn(Playlist playlist) async {}
}

class Playlist {
  final String id;
  final List<Image> images;
  final String description;
  final String name;
  final int tracksCount;

  const Playlist({
    required this.id,
    required this.images,
    required this.description,
    required this.name,
    required this.tracksCount,
  });
}

class Track {}
