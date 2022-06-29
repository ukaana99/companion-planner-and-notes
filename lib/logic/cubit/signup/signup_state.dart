part of 'signup_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.obscurePassword = true,
    this.obscurePassword2 = true,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;
  final bool obscurePassword;
  final bool obscurePassword2;

  @override
  List<Object> get props => [
        email,
        password,
        confirmedPassword,
        status,
        obscurePassword,
        obscurePassword2,
      ];

  SignUpState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    String? errorMessage,
    bool? obscurePassword,
    bool? obscurePassword2,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscurePassword2: obscurePassword2 ?? this.obscurePassword2,
    );
  }
}
