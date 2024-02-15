part of fireside;

class FiresideLaunchView extends StatefulWidget {
  const FiresideLaunchView({super.key});
  @override
  _FiresideLaunchViewState createState() => _FiresideLaunchViewState();
}

class _FiresideLaunchViewState extends State<FiresideLaunchView> {
  String? authHtmlCode;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (!AuthService.isAuthorized) {
        Navigator.of(context).pushNamed('/auth');
      } else {
        Navigator.of(context).pushNamed('/shelf');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text('Launch View'),
      ),
    );
  }
}
