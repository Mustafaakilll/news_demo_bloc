import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_navigation_bloc/app_navigation_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_state.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this.authRepo, this.appNavigationCubit) : super(SignUpState());

  final AuthRepository authRepo;
  final AppNavigationCubit appNavigationCubit;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    /// EMAIL CHANGED
    if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

      /// PASSWORD CHANGED
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

      /// SIGN UP SUBMIT
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final _user = await authRepo.signUp(state.email, state.password);
        yield state.copyWith(formStatus: SubmissionSuccess(_user));
        appNavigationCubit.showSession();
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailure(e));
      }

      /// SIGN IN WITH GOOGLE
    } else if (event is SignInWithGoogle) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final user = await authRepo.signInWithGoogle();
        yield state.copyWith(formStatus: SubmissionSuccess(user));
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailure(e));
      }
    }
  }
}
