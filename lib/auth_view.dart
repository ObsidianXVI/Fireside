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
              await AuthService.performAuth();

              if (mounted) {
                Navigator.of(context).pushNamed('/launch');
              }
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
