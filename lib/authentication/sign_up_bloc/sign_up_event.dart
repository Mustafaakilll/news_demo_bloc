abstract class SignUpEvent {
  const SignUpEvent();
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged(this.email);
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged(this.password);
}

class SignInWithGoogle extends SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {}
