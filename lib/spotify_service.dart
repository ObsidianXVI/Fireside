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
            uri: item['uri'],
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

  static Future<List<Track>> getTracksInPlaylist(Playlist playlist) async {
    return await AuthService.withToken<List<Track>>((String token) async {
      final List<Track> tracks = [];
      final Map res = jsonDecode((await get(
        Uri.https('api.spotify.com', '/v1/playlists/${playlist.id}/tracks'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ))
          .body);
      (res['items'] as List).removeWhere((e) => e['track']['id'] == null);
      int offset = 0;
      for (Map trackItem in res['items']) {
        tracks.add(
          Track(
            id: trackItem['track']['id'],
            offset: offset,
            artists: [
              for (Map artist in trackItem['track']['artists']) artist['name']
            ],
            duration: Duration(
                milliseconds: trackItem['track']['duration_ms'] as int),
            name: trackItem['track']['name'],
            playlistUri: playlist.uri,
            uri: trackItem['track']['uri'],
            image: Image.network(
              trackItem['track']['album']['images'][0]['url'],
              width: trackItem['track']['album']['images'][0]['width'],
              height: trackItem['track']['album']['images'][0]['height'],
              fit: BoxFit.cover,
            ),
          ),
        );
        offset += 1;
      }
      return tracks;
    });
  }

  static Future<void> playTrack(Track track) async {
    return await AuthService.withToken<void>((String token) async {
      (await put(Uri.https('api.spotify.com', '/v1/me/player/play'),
              headers: {
                'Authorization': 'Bearer $token',
              },
              body: jsonEncode({
                'context_uri': track.playlistUri,
                'offset': {
                  'position': track.offset,
                },
                // 'uris': [track.uri],
              })))
          .body;
      // await restoreQueue(queue);
    });
  }

  static Future<String> getContextUri() async {
    return await AuthService.withToken<String>((String token) async {
      final Map res = jsonDecode(
          (await get(Uri.https('api.spotify.com', '/v1/me/player'), headers: {
        'Authorization': 'Bearer $token',
      }))
              .body);
      return res['context']['uri'];
    });
  }

  static Future<List<String>> getQueue() async {
    return await AuthService.withToken<List<String>>((String token) async {
      final Map res = jsonDecode((await get(
              Uri.https('api.spotify.com', '/v1/me/player/queue'),
              headers: {
            'Authorization': 'Bearer $token',
          }))
          .body);

      final List<String> queue = [for (Map m in res['queue']) m['uri']];
      return queue;
    });
  }

  static Future<void> restoreQueue(List<String> queue) async {
    return await AuthService.withToken((String token) async {
      for (String uri in queue) {
        await post(
          Uri.https('api.spotify.com', '/v1/me/player/queue', {
            'uri': uri,
          }),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
      }
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

  static Future<void> skipToNext() async {
    return await AuthService.withToken((String token) async {
      await post(Uri.https('api.spotify.com', '/v1/me/player/next'), headers: {
        'Authorization': 'Bearer $token',
      });
    });
  }

  static Future<void> skipToPrevious() async {
    return await AuthService.withToken((String token) async {
      await post(Uri.https('api.spotify.com', '/v1/me/player/previous'),
          headers: {
            'Authorization': 'Bearer $token',
          });
    });
  }
}

abstract class SpotifyObject {
  final String name;

  final String id;
  final String uri;
  final Image image;
  const SpotifyObject({
    required this.name,
    required this.id,
    required this.uri,
    required this.image,
  });
}

class Playlist extends SpotifyObject {
  final String description;
  final int tracksCount;

  const Playlist({
    required this.description,
    required this.tracksCount,
    required super.name,
    required super.id,
    required super.uri,
    required super.image,
  });
}

class Track extends SpotifyObject {
  final int offset;
  final List<String> artists;
  final Duration duration;
  final String playlistUri;

  const Track({
    required this.offset,
    required this.artists,
    required this.duration,
    required this.playlistUri,
    required super.name,
    required super.id,
    required super.uri,
    required super.image,
  });
}
