abstract class LoginEvent {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged(this.email);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);
}

class LoginWithGoogle extends LoginEvent {}

class LoginSubmitted extends LoginEvent {}
