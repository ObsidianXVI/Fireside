part of fireside;

class FiresideAuthView extends StatefulWidget {
  const FiresideAuthView({super.key});

  @override
  State<StatefulWidget> createState() => FiresideAuthViewState();
}

class FiresideAuthViewState extends State<FiresideAuthView> {
  String res = 'waiting';
  @override
  void initState() {
    super.initState();
  }

  Future<void> connectToSpotify() async {
    clientId = jsonDecode(
        await rootBundle.loadString('assets/secrets.json'))['clientId'];
    token = await SpotifySdk.getAccessToken(
      clientId: clientId,
      redirectUrl: "http://localhost:8990/",
      scope: "user-read-playback-state",
    );
    print(token);
    print('Got Token');
  }

  Future<void> showPlayerState() async {
    final Response res = await get(
      Uri.https('api.spotify.com', '/v1/me/player'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                try {
                  await connectToSpotify();
                } catch (e) {
                  // This simple try-catch solves a lot of problems, so we'll
                  // just leave it here
                }
              },
              child: const Text('Connect to Spotify'),
            ),
            TextButton(
              onPressed: () async {
                await showPlayerState();
              },
              child: const Text('Get player info'),
            ),
          ],
        ),
      ),
    );
  }
}
