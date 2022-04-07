import 'package:flutter/material.dart';

import '../../../app/app_router.dart';

class InitialView extends StatelessWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      var hasSignedInUser = true;
      if (hasSignedInUser) {
        // final user = currentUser;
        Navigator.of(context).pushReplacementNamed(AppRouter.home);
        // ignore: dead_code
      } else {
        Navigator.of(context).pushReplacementNamed(AppRouter.login);
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              width: 100,
              height: 100,
              child: Image.asset('assets/icons/companion.png'),
            ),
            const SizedBox(height: 40),
            const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal)),
            ),
          ],
        ),
      ),
    );
  }
}
