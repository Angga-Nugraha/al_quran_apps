import 'package:flutter/material.dart';

import '../../common/routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Hero(
                    tag: Image,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'QURAN - EVO',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Muslim App',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(120, 50),
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, rootScreenPageRoutes),
                child: const Text(
                  'Get started now',
                  style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
