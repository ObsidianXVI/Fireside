part of fireside;

class TrackItem extends StatelessWidget {
  final Track track;
  const TrackItem({
    required this.track,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          FiresideState.currentTrack = track;
          Navigator.of(context).pushNamed('/player');
        },
        child: Container(
          clipBehavior: Clip.none,
          width: 620,
          height: 320,
          color: Colors.red,
          child: Stack(
            children: [
              Positioned(
                top: -10,
                right: -50,
                child: Container(
                  width: 320,
                  height: 320,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: vinylRecordImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              /* Positioned(
                left: 0,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: track.image.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
