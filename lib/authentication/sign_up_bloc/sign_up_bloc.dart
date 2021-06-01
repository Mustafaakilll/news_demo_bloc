import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_repository.dart';
import '../form_submission_state.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this.authRepo) : super(SignUpState());

  final AuthRepository authRepo;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final _user = await authRepo.signUp(state.email, state.password);
        yield state.copyWith(formStatus: SubmissionSuccess(_user));
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailure(e));
      }
    } else if (event is SignInWithGoogle) {
      //TODO:GOOGLE ILE GIRIS YAP
    }
  }
}
