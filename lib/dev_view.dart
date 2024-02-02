part of fireside;

class FiresideDevView extends StatefulWidget {
  const FiresideDevView({
    super.key,
  });

  @override
  createState() => FiresideDevViewState();
}

class FiresideDevViewState extends State<FiresideDevView> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.purple,
      child:
          SizedBox(), /* FiresideShelfView<Track>(
        items: List<Track>.generate(
          15,
          (index) => Track(
            id: 'id',
            offset: 0,
            artists: [],
            duration: const Duration(seconds: 20),
            name: 'name',
            uri: 'uri',
            playlistUri: 'playlistUri',
            image: Image.asset(
              'images/kid_cudi.jpg',
            ),
          ),
        ),
        createWidget: (track) => RecordSleeveWidget(
          track: track,
          callback: () {},
        ),
      ), */
    );
  }
}
