part of fireside;

class FiresideDevView extends StatefulWidget {
  const FiresideDevView({
    super.key,
  });

  @override
  createState() => FiresideDevViewState();
}

class FiresideDevViewState extends State<FiresideDevView> {
  final ScrollController scrollController = FixedExtentScrollController();
  final List<Track> tracks = List<Track>.generate(
      5,
      (_) => Track(
            offset: 0,
            artists: ['Kid Cudi', 'Trippie Redd'],
            duration: Duration.zero,
            playlistUri: '',
            name: 'Rockstar Knights',
            id: 'id',
            uri: 'uri',
            image: Image.asset('images/kid_cudi.jpg'),
          ));

  Color bgColor = Colors.transparent;
  Color textColor = Colors.transparent;
  int currentIndex = 0;

  Future<void> updateColors(ImageProvider imageProvider) async {
    final ColorScheme scheme =
        await ColorScheme.fromImageProvider(provider: imageProvider);
    setState(() {
      bgColor = scheme.secondaryContainer;
      textColor = scheme.primary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: Container(
                width: 400,
                height: 900,
                child: ListWheelScrollView(
                  clipBehavior: Clip.none,
                  controller: scrollController,
                  renderChildrenOutsideViewport: true,
                  physics: const FixedExtentScrollPhysics(),
                  itemExtent: 300,
                  offAxisFraction: 1.5,
                  diameterRatio: 4.4,
                  squeeze: 0.96,
                  onSelectedItemChanged: (index) async {
                    currentIndex = index;
                    await updateColors(tracks[index].image.image);
                  },
                  children: [
                    for (final track in tracks) TrackItem(track: track)
                  ],
                ),
              ),
            ),
            Positioned(
              right: 50,
              top: 150,
              child: SizedBox(
                width: 750,
                height: 900,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        tracks[currentIndex].name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 170,
                          height: 0.8,
                        ),
                      ),
                      const SizedBox(height: 80),
                      Text(
                        tracks[currentIndex].artists.join(', '),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: textColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 50,
                          height: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
