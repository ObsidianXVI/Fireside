part of fireside;

class VinylWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('images/vinyl_1.png'),
      fit: BoxFit.cover,
    );
  }
}
