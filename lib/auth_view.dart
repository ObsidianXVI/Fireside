part of fireside;

class FiresideAuthView extends StatefulWidget {
  const FiresideAuthView({super.key});

  @override
  State<StatefulWidget> createState() => FiresideAuthViewState();
}

class FiresideAuthViewState extends State<FiresideAuthView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: TextButton(
          onPressed: () async {
            try {
              AuthService.performAuth()
                  .then((_) => Navigator.of(context).pushNamed('/shelf'));
            } catch (e) {
              // This simple try-catch solves a lot of problems, so we'll
              // just leave it here
            }
          },
          child: const Text('Connect to Spotify'),
        ),
      ),
    );
  }
}
