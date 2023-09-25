part of 'components_helpers.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: Image,
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
            ),
            const SizedBox(
              child: Column(
                children: [
                  Text(
                    'QURAN - EVO',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Muslim App',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            const SizedBox(height: 100.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                minimumSize: const Size(150, 50),
              ),
              onPressed: () async {
                locator<PreferencesHelper>().setFirstTime(false);
                Navigator.pushReplacementNamed(context, rootScreenPageRoutes);
              },
              child: const Text(
                'Get started now',
                style: TextStyle(fontSize: 16, letterSpacing: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
