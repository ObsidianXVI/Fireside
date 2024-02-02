part of fireside;

class ShelfItem extends StatefulWidget {
  final Playlist playlist;
  const ShelfItem({
    required this.playlist,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ShelfItemState();
}

class ShelfItemState extends State<ShelfItem> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          FiresideState.currentPlaylist = widget.playlist;
          Future.delayed(Duration.zero, () {
            Navigator.pushNamed(context, '/carousel');
          });
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.playlist.image.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
