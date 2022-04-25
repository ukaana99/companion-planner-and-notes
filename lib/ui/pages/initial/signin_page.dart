import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/signin_form.dart';

import '../../../data/repositories/auth_repo.dart';
import '../../../logic/cubit/signin/signin_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => SignInCubit(context.read<AuthRepository>()),
          child: const SignInForm(),
        ),
      ),
    );
  }
}
