import 'package:firebase_auth/firebase_auth.dart';

abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {
  final User? user;

  SubmissionSuccess(this.user);
}

class SubmissionFailure extends FormSubmissionStatus {
  final Exception exception;

  SubmissionFailure(this.exception);
}
