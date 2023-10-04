part of fireside;

class VinylWidget extends StatelessWidget {
  /// The radius-ish of the inner circle
  static const double _innerRadius = 120;

  /// The distance-ish from the top of the record to the top of the inner circle
  static const double _distFromTop = 232;

  final ImageProvider trackImage;

  const VinylWidget({
    required this.trackImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          right: 10,
          bottom: 10,
          child: Container(
            width: 680,
            height: 680,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 700,
          height: 700,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('images/vinyl_1.png'),
            ),
            borderRadius: BorderRadius.circular(100),
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
                image: trackImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
