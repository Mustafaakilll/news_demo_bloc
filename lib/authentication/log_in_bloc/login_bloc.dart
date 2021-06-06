import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_navigation_bloc/app_navigation_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_state.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.authRepo, this.appNavigationCubit) : super(LoginState());

  final AuthRepository authRepo;
  final AppNavigationCubit appNavigationCubit;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    /// UPADTE LOGIN STATE'S PASSWORD
    if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      /// UPADTE LOGIN STATE'S EMAIL
    } else if (event is LoginEmailChanged) {
      yield state.copyWith(email: event.email);

      /// SUBMIT LOGIN
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final user =
            await authRepo.signInWithEmail(state.email, state.password);
        yield state.copyWith(formStatus: SubmissionSuccess(user));

        /// GO TO NEWS SCREEN
        appNavigationCubit.showSession();
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailure(e));
      }

      /// LOGIN WITH GOOGLE
    } else if (event is LoginWithGoogle) {
      try {
        final user = await authRepo.signInWithGoogle();
        yield state.copyWith(formStatus: SubmissionSuccess(user));
      } on Exception catch (e) {
        yield state.copyWith(formStatus: SubmissionFailure(e));
      }
    }
  }
}
