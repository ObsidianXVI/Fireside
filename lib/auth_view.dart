part of fireside;

class FiresideAuthView extends StatefulWidget {
  const FiresideAuthView({super.key});

  @override
  State<StatefulWidget> createState() => FiresideAuthViewState();
}

class FiresideAuthViewState extends State<FiresideAuthView> {
  String res = 'waiting';
  @override
  void initState() {
    print("Located:${Uri.base}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text('FiresideAuthView'),
      ),
    );
  }
}
