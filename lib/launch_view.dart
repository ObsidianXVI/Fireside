part of fireside;

class FiresideLaunchView extends StatefulWidget {
  const FiresideLaunchView({super.key});
  @override
  _FiresideLaunchViewState createState() => _FiresideLaunchViewState();
}

class _FiresideLaunchViewState extends State<FiresideLaunchView> {
  String? authHtmlCode;

  @override
  void initState() {
    get(
      Uri.https(
        'api.spotify.com',
        'v1/me/player/currently-playing',
        {
          'Authorization': 'Bearer $token',
        },
      ),
    ).then((res) {
      print(res.body);
    });
/*     final Uri uri = Uri.https(
      'accounts.spotify.com',
      '/authorize',
      {
        'client_id': clientId,
        'response_type': 'code',
        'redirect_uri': 'http://localhost:56615/#/auth', //',
        'code_challenge_method': 'S256',
        'code_challenge': '12345678',
      },
    );

    print(uri.toString());
    get(uri).then((Response res) => setState(() {
          authHtmlCode = res.body;
        }));
 */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text('FiresideLaunchView'),
      ),
    );
  }
}
