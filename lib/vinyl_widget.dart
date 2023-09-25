part of fireside;

class VinylWidget extends StatelessWidget {
  /// The radius-ish of the inner circle
  static const double _innerRadius = 120;

  /// The distance-ish from the top of the record to the top of the inner circle
  static const double _distFromTop = 232;

  final Image trackImage;

  const VinylWidget({
    required this.trackImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 700,
          height: 700,
          child: const Image(
            image: AssetImage('images/vinyl_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: _distFromTop,
          left: _distFromTop,
          width: 2 * _innerRadius,
          height: 2 * _innerRadius,
          child: Container(
            width: 2 * _innerRadius,
            height: 2 * _innerRadius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: trackImage.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
