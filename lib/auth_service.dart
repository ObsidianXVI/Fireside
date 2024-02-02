part of fireside;

class AuthService {
  static const String scopes =
      "playlist-read-collaborative playlist-read-private user-modify-playback-state user-read-playback-state";
  static String? _authToken;
  static String get authToken => _authToken ?? '';
  static bool get isAuthorized => _authToken != null;

  static Future<T> withToken<T>(Future<T> Function(String) action,
      [BuildContext? context]) {
    if (debugToken != null) return action(debugToken!);
    if (isAuthorized) {
      return action(_authToken!);
    } else {
      throw Exception('no_auth_token');
    }
  }

  static Future<void> performAuth() async {
    _authToken = await SpotifySdk.getAccessToken(
      clientId: clientId,
      redirectUrl: "http://localhost:8990/",
      scope: scopes,
    );
  }
}
