part of 'signin_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.obscurePassword = true,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final bool obscurePassword;

  @override
  List<Object> get props => [email, password, status, obscurePassword];

  SignInState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
    bool? obscurePassword,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
