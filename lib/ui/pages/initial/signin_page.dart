import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../app/app_router.dart';
import '../../../app/app_theme.dart';
import '../../../data/repositories/auth_repo.dart';
import '../../../logic/cubit/signin/signin_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => SignInCubit(context.read<AuthRepository>()),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            Image.asset(
              'assets/images/flat-geometric.png',
            ),
            const SizedBox(height: 48),
            Center(
              child: Text(
                'Sign in',
                style: TextStyle(
                  color: Theme.of(context).textColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const SignInForm(),
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pushReplacementNamed(AppRouter.main);
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign in failure')),
            );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _EmailInput(),
            const SizedBox(height: 16),
            _PasswordInput(),
            const SizedBox(height: 60),
            _SignInButton(),
            const SizedBox(height: 16),
            _ForgotPasswordButton(),
            const SizedBox(height: 120),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final email = context.select((SignInCubit cubit) => cubit.state.email);

    return TextField(
      onChanged: (email) => context.read<SignInCubit>().emailChanged(email),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        errorText: email.invalid ? 'Invalid e-mail' : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final password =
        context.select((SignInCubit cubit) => cubit.state.password);
    final obscurePassword =
        context.select((SignInCubit cubit) => cubit.state.obscurePassword);

    return TextField(
      onChanged: (password) =>
          context.read<SignInCubit>().passwordChanged(password),
      obscureText: obscurePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: obscurePassword
              ? const Icon(FontAwesomeIcons.eye)
              : const Icon(FontAwesomeIcons.eyeSlash),
          onPressed: () => context.read<SignInCubit>().obscurePasswordToggled(),
        ),
        labelText: 'Password',
        errorText: password.invalid ? 'Invalid password' : null,
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final status = context.select((SignInCubit cubit) => cubit.state.status);

    return status.isSubmissionInProgress
        ? Container(
            padding: const EdgeInsets.all(6),
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          )
        : ElevatedButton(
            onPressed: status.isValidated
                ? () => context.read<SignInCubit>().signInWithCredentials()
                : null,
            child: const SizedBox(
              height: 40,
              child: Center(child: Text('Sign in')),
            ),
          );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const SizedBox(
        height: 40,
        child: Center(child: Text('Forgot password')),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(AppRouter.signup),
          child: Text(
            "Sign up",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
