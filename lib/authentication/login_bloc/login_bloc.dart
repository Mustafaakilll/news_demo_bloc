import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_repository.dart';
import '../form_submission_state.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authRepo) : super(LoginState());

  final AuthRepository authRepo;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final user =
            await authRepo.signInWithEmail(state.email, state.password);
        yield state.copyWith(formStatus: SubmissionSuccess(user));
        //TODO: GO TO NEWS PAGE
        //TODO: SIGNUP BLOC AND VIEW
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailure(e));
      }
    } else if (event is LoginWithGoogle) {
      //TODO: SIGN IN WITH GOOGLE
    }
  }
}
