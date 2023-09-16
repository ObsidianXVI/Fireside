import 'dart:io';

const flutterPath = '/usr/local/bin/flutter/bin/flutter';
void main(List<String> args) async {
  final HttpServer server = await HttpServer.bind('localhost', 8990);
  server.listen((HttpRequest req) async {
    req.response.headers.set('Content-Type', 'text/html');

    req.response.write("""
<!DOCTYPE html>
<html>

<head>
    <title>Authenticating Spotify</title>
</head>

<body>
    <p>Please wait while we authenticate Spotify...</p>
    <script type="text/javascript">
        if (window.opener) {
            window.opener.postMessage('?' + window.location.href.split('?')[1], "*");
        } else {
            window.close();
        }
    </script>
</body>

</html>
""");
    await req.response.close();
  });
}
