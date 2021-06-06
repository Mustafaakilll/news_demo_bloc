import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_navigation_bloc/app_navigation_cubit.dart';
import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_state.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        context.read<AuthRepository>(),
        context.read<AppNavigationCubit>(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: _loginForm(),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Giris Yap'),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;

        /// IF LOGIN FAILED SHOW ERROR ON SNACKBAR
        if (formStatus is SubmissionFailure) {
          _snackBarMessenger(formStatus.exception.toString(), context);

          /// IF LOGIN SUCCESS SHOW USER EMAIL ON SNACKBAR
        } else if (formStatus is SubmissionSuccess) {
          _snackBarMessenger('Hos Geldiniz ${formStatus.user!.email}', context);
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                _emailField(),
                _passwordField(),
                _submitButton(),
              ],
            ),
            Flex(
              direction: Axis.vertical,
              children: [_signUpButton(), _googleSignIn()],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) => state.isValidEmail
              ? null
              : 'Gecerli bir email girdiniziden emin olun',
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginEmailChanged(value)),
          decoration: const InputDecoration(
            hintText: 'Email Adresi',
            icon: Icon(Icons.person),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) => state.isValidPassword
              ? null
              : 'Sifre en az 6 karakter olmalidir.',
          onChanged: (value) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(value)),
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Parola',
            icon: Icon(Icons.security),
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, _) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).backgroundColor,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(LoginSubmitted());
              FocusScope.of(context).unfocus();
            }
          },
          child: const Text('Giris Yap'),
        );
      },
    );
  }

  Widget _signUpButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, _) {
        return TextButton(
          onPressed: () => context.read<AuthNavigationCubit>().showSignUp(),
          child: const Text('Hemen Kayit Ol'),
        );
      },
    );
  }

  Widget _googleSignIn() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, _) {
        return ElevatedButton(
          onPressed: () => context.read<LoginBloc>().add(LoginWithGoogle()),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).backgroundColor,
          ),
          child: const Text('Google ile giris yap'),
        );
      },
    );
  }

  void _snackBarMessenger(String text, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
