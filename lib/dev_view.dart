part of fireside;

class FiresideDevView extends StatelessWidget {
  const FiresideDevView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.green,
          child: Center(
            child: Container(
              width: 800,
              height: 800,
              color: Colors.amber,
              child: const Center(
                  child: VinylWidget(
                      trackImage:
                          Image(image: AssetImage('images/kid_cudi.jpg')))),
            ),
          ),
        ),
      ),
    );
  }
}
