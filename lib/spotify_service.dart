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
        final Map res2 = jsonDecode((await get(
          Uri.https('api.spotify.com', '/v1/playlists/${item['id']}/tracks'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        ))
            .body);
        (res2['items'] as List).removeWhere((e) => e['track']['id'] == null);
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
            tracks: [
              for (Map? trackItem in res2['items'])
                if (trackItem != null && trackItem['track'] != null)
                  Track(
                    id: trackItem['track']['id'],
                    artists: [
                      for (Map artist in trackItem['track']['artists'])
                        artist['name']
                    ],
                    duration: Duration(
                        milliseconds: trackItem['track']['duration_ms'] as int),
                    name: trackItem['track']['name'],
                    uri: trackItem['track']['uri'],
                    image: Image.network(
                      trackItem['track']['album']['images'][0]['url'],
                      width: trackItem['track']['album']['images'][0]['width'],
                      height: trackItem['track']['album']['images'][0]
                          ['height'],
                      fit: BoxFit.cover,
                    ),
                  ),
            ],
          ),
        );
      }
      return playlists;
    });
  }

  static Future<List<Track>> getTracks(List<String> trackIds) async {
    return await AuthService.withToken<List<Track>>((String token) async {
      final List<Track> tracks = [];
      final Map res = jsonDecode((await get(
        Uri.https('api.spotify.com', '/v1/tracks', {
          'ids': trackIds.join(','),
        }),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ))
          .body);
      for (Map item in res['tracks']) {
        tracks.add(
          Track(
            id: item['id'],
            uri: item['uri'],
            name: item['name'],
            duration: Duration(milliseconds: item['duration'] as int),
            artists: [for (Map artist in item['artists']) artist['name']],
            image: Image.network(
              item['album']['images'][0]['url'],
              width: item['album']['images'][0]['width'],
              height: item['album']['images'][0]['height'],
              fit: BoxFit.cover,
            ),
          ),
        );
      }
      return tracks;
    });
  }
}

class Playlist {
  final String id;
  final Image image;
  final String description;
  final String name;
  final int tracksCount;
  final List<Track> tracks;

  const Playlist({
    required this.id,
    required this.image,
    required this.description,
    required this.name,
    required this.tracksCount,
    required this.tracks,
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
