import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_router.dart';
import '../../../logic/bloc/app/app_bloc.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasSignedInUser =
        context.select((AppBloc bloc) => bloc.state.user).isNotEmpty;
    Future.delayed(const Duration(seconds: 1), () {
      if (hasSignedInUser) {
        Navigator.of(context).pushReplacementNamed(AppRouter.main);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRouter.signin);
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
              child: Theme.of(context).brightness == Brightness.light
                  ? Image.asset('assets/icons/companion1.png')
                  : Image.asset('assets/icons/companion2.png'),
            ),
            const SizedBox(height: 40),
            Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor)),
            ),
          ],
        ),
      ),
    );
  }
}
