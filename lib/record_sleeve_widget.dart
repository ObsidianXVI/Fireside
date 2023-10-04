part of fireside;

class RecordSleeveWidget extends StatelessWidget {
  final Track track;
  final Function callback;

  const RecordSleeveWidget({
    required this.track,
    required this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 250,
      child: GestureDetector(
        onTap: () => callback(),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('images/vinyl_1.png'),
                  ),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: Container(
                width: 250,
                height: 250,
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 20,
                        offset: const Offset(-10, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              width: 230,
              height: 250,
              child: Container(
                width: 230,
                height: 250,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Image(
                  image: track.image.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 2,
              bottom: 2,
              child: Text(track.name),
            ),
          ],
        ),
      ),
    );
  }
}
