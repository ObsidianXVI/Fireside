library fireside;

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

part './auth_service.dart';
part 'spotify_service.dart';

part './auth_view.dart';
part './launch_view.dart';
part './shelf_view.dart';
part './player_view.dart';

part './vinyl_widget.dart';
part './needle_widget.dart';

late final String clientId;
late final String username;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Map secrets =
      jsonDecode(await rootBundle.loadString('assets/secrets.json'));
  clientId = secrets['clientId'];
  username = secrets['username'];

  runApp(const FiresideApp());
}

class FiresideApp extends StatelessWidget {
  //static const Track currentTrack;
  const FiresideApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fireside',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/launch',
      routes: {
        '/launch': (_) => const FiresideLaunchView(),
        '/player': (_) => const FiresidePlayer(),
        '/shelf': (_) =>
            const FiresideShelfView(showPlaylists: true, playlist: null),
        '/test': (_) => MyApp(),
        '/auth': (_) => const FiresideAuthView(),
      },
    );
  }
}

