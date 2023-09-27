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
            image: Image.network(
              item['images'][0]['url'],
              width: item['images'][0]['width'],
              height: item['images'][0]['height'],
              fit: BoxFit.cover,
            ),
            description: item['description'],
            name: item['name'],
            tracksCount: item['tracks']['total'],
          ),
        );
      }
      return playlists;
    });
  }

  static Future<List<Track>> getTracksInPlaylist(String playlistId) async {
    return await AuthService.withToken<List<Track>>((String token) async {
      final List<Track> tracks = [];
      final Map res = jsonDecode((await get(
        Uri.https('api.spotify.com', '/v1/playlists/$playlistId/tracks'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ))
          .body);
      (res['items'] as List).removeWhere((e) => e['track']['id'] == null);

      for (Map trackItem in res['items']) {
        tracks.add(
          Track(
            id: trackItem['track']['id'],
            artists: [
              for (Map artist in trackItem['track']['artists']) artist['name']
            ],
            duration: Duration(
                milliseconds: trackItem['track']['duration_ms'] as int),
            name: trackItem['track']['name'],
            uri: trackItem['track']['uri'],
            image: Image.network(
              trackItem['track']['album']['images'][0]['url'],
              width: trackItem['track']['album']['images'][0]['width'],
              height: trackItem['track']['album']['images'][0]['height'],
              fit: BoxFit.cover,
            ),
          ),
        );
      }
      return tracks;
    });
  }

  static Future<void> playTrack(Track track) async {
    return await AuthService.withToken<void>((String token) async {
      final Map res = jsonDecode(
          (await put(Uri.https('api.spotify.com', '/v1/me/player/play'),
                  headers: {
                    'Authorization': 'Bearer $token',
                  },
                  body: jsonEncode({
                    'uris': [track.uri],
                  })))
              .body);
      print(res);
    });
  }

  static Future<void> pausePlayback() async {
    return await AuthService.withToken<void>((String token) async {
      final Map res = jsonDecode((await put(
        Uri.https('api.spotify.com', '/v1/me/player/pause'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ))
          .body);
    });
  }

  static Future<void> resumePlayback() async {
    return await AuthService.withToken<void>((String token) async {
      final Map res = jsonDecode((await put(
        Uri.https('api.spotify.com', '/v1/me/player/play'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ))
          .body);
    });
  }
}

class Playlist {
  final String id;
  final Image image;
  final String description;
  final String name;
  final int tracksCount;

  const Playlist({
    required this.id,
    required this.image,
    required this.description,
    required this.name,
    required this.tracksCount,
  });
}

class Track {
  final String id;
  final List<String> artists;
  final Duration duration;
  final String name;
  final String uri;
  final Image image;

  const Track({
    required this.id,
    required this.artists,
    required this.duration,
    required this.name,
    required this.uri,
    required this.image,
  });
}
