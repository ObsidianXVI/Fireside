part of fireside;

class AuthService {
  static String? _authToken;
  static String get authToken => _authToken ?? '';
  static bool get isAuthorized => _authToken != null;

  static Future<T?> withToken<T>(Future<T> Function(String) action,
      [BuildContext? context]) {
    if (_authToken != null) {
      return action(_authToken!);
    } else {
      if (context != null) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                child: const Center(
                  child: Text('No auth token found'),
                ),
              ),
            );
          },
        );
      } else {
        throw Exception('no_auth_token');
      }
    }
  }

  static Future<void> performAuth() async {
    _authToken = await SpotifySdk.getAccessToken(
      clientId: clientId,
      redirectUrl: "http://localhost:8990/",
      scope: "user-read-playback-state",
    );
    print('Got Token');
  }
}
