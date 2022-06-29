import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import '../../../app/app_router.dart';
import '../../../app/app_theme.dart';
import '../../../data/repositories/auth_repo.dart';
import '../../../logic/cubit/signup/signup_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      lazy: false,
      create: (_) => SignUpCubit(context.read<AuthRepository>()),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

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
                'Sign up',
                style: TextStyle(
                  color: Theme.of(context).textColor,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const SignUpForm(),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.main,
            (route) => false,
          );
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign up failure')),
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
            const SizedBox(height: 16),
            _ConfirmPasswordInput(),
            const SizedBox(height: 60),
            _SignUpButton(),
            const SizedBox(height: 8),
            _SignUpText(),
            const SizedBox(height: 68),
            _SignInButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final email = context.select((SignUpCubit cubit) => cubit.state.email);

    return TextField(
      onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
        context.select((SignUpCubit cubit) => cubit.state.password);
    final obscurePassword =
        context.select((SignUpCubit cubit) => cubit.state.obscurePassword);

    return TextField(
      onChanged: (password) =>
          context.read<SignUpCubit>().passwordChanged(password),
      obscureText: obscurePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: obscurePassword
              ? const Icon(FontAwesomeIcons.eye)
              : const Icon(FontAwesomeIcons.eyeSlash),
          onPressed: () => context.read<SignUpCubit>().obscurePasswordToggled(),
        ),
        labelText: 'Password',
        errorText: password.invalid ? 'Invalid password' : null,
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final confirmedPassword =
        context.select((SignUpCubit cubit) => cubit.state.confirmedPassword);
    final obscurePassword2 =
        context.select((SignUpCubit cubit) => cubit.state.obscurePassword2);

    return TextField(
      onChanged: (confirmPassword) =>
          context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
      obscureText: obscurePassword2,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: obscurePassword2
              ? const Icon(FontAwesomeIcons.eye)
              : const Icon(FontAwesomeIcons.eyeSlash),
          onPressed: () =>
              context.read<SignUpCubit>().obscurePassword2Toggled(),
        ),
        labelText: 'Confirm password',
        errorText: confirmedPassword.invalid ? 'Passwords do not match' : null,
      ),
    );
  }
}

class _SignUpText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: 14.0,
          color: Theme.of(context).hintColor,
        ),
        children: <TextSpan>[
          const TextSpan(text: 'By signing up, you agree to the '),
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          const TextSpan(text: ', including '),
          TextSpan(
            text: 'Cookie Use',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final status = context.select((SignUpCubit cubit) => cubit.state.status);

    return status.isSubmissionInProgress
        ? Container(
            padding: const EdgeInsets.all(6),
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          )
        : ElevatedButton(
            onPressed: status.isValidated
                ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                : null,
            child: const SizedBox(
              height: 40,
              child: Center(child: Text('Sign up')),
            ),
          );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Text(
            "Sign in",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
