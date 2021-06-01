import '../form_submission_state.dart';

class SignUpState {
  final String email;
  final String password;
  final FormSubmissionStatus formStatus;

  bool get isValidEmail => email.contains('@');
  bool get isValidPassword => password.length > 6;

  SignUpState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignUpState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
