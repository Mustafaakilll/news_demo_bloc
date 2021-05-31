import '../form_submission_state.dart';

class LoginState {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidEmail => email.contains('@');
  bool get isValidPassword => password.length > 6;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
