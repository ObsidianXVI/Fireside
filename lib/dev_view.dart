part of fireside;

class FiresideDevView extends StatefulWidget {
  const FiresideDevView({
    super.key,
  });

  createState() => FiresideDevViewState();
}

class FiresideDevViewState extends State<FiresideDevView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.purple,
/*       child: Center(
        child: RecordSleeveWidget(
          track: const AssetImage('images/kid_cudi.jpg'),
          callback: () {},
        ),
      ), */
    );
  }
}
