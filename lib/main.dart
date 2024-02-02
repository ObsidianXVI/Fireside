library fireside;

import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

part './auth_service.dart';
part './spotify_service.dart';

part './auth_view.dart';
part './launch_view.dart';
part './shelf_view.dart';
part 'track_carousel_view.dart';
part './player_view.dart';
part './dev_view.dart';

part './ui_components/shelf_item.dart';
part './ui_components/track_item.dart';

part './vinyl_widget.dart';
part './tonearm_widget.dart';
part './record_sleeve_widget.dart';

late final String clientId;
late final String username;
const AssetImage vinylRecordImg = AssetImage('images/vinyl_1.png');

// For dev purposes only
const String? debugToken =
    "BQBWF1ZCuuZQ_iWEbjhlCFgtiiq_os-rPA341gq10R1FgJjqsxQ30YtL7sHqJBg_njQ85dcEPX51hrvzC6ive7C21a6Hd81ehB-GGX4UnQR3YpN44PC8_bocIuAOD0NUhjsiw25N1YqvnHFJnUWcVXK9g-IsfxQ1wWDzIcft7NNw-Ynmsqre61F9D9mFqRKJ9iZFpTgSmCjLVl5SY-pbROqqYw_-";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Map secrets =
      jsonDecode(await rootBundle.loadString('assets/secrets.json'));
  clientId = secrets['clientId'];
  username = secrets['username'];
  runApp(const FiresideApp());
}

class FiresideApp extends StatelessWidget {
  const FiresideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fireside',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/launch',
      routes: {
        '/launch': (_) => const FiresideLaunchView(),
        '/shelf': (_) => const FiresideShelfView(),
        '/carousel': (_) => const FiresideTrackCarouselView(),
        '/player': (_) => const FiresidePlayer(),
        '/auth': (_) => const FiresideAuthView(),
        '/dev': (_) => const FiresideDevView(),
      },
    );
  }
}

class FiresideState {
  static Track? currentTrack;
  static Playlist? currentPlaylist;
}
