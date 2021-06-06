import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_navigation_bloc/app_navigation_cubit.dart';
import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_state.dart';
import 'sign_up_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        context.read<AuthRepository>(),
        context.read<AppNavigationCubit>(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: _signUpForm(),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Kayit Ol'),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
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
              children: [_signInButton(), _googleSignIn()],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) => state.isValidEmail
              ? null
              : 'Gecerli bir email girdiniziden emin olun',
          onChanged: (value) =>
              context.read<SignUpBloc>().add(SignUpEmailChanged(value)),
          decoration: const InputDecoration(
            hintText: 'Email Adresi',
            icon: Icon(Icons.person),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) => state.isValidPassword
              ? null
              : 'Sifre en az 6 karakter olmalidir.',
          onChanged: (value) =>
              context.read<SignUpBloc>().add(SignUpPasswordChanged(value)),
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).backgroundColor,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<SignUpBloc>().add(SignUpSubmitted());
              FocusScope.of(context).unfocus();
            }
          },
          child: const Text('Kayit Ol'),
        );
      },
    );
  }

  Widget _signInButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () => context.read<AuthNavigationCubit>().showLogin(),
          child: const Text('Hemen Giris Yap'),
        );
      },
    );
  }

  Widget _googleSignIn() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => context.read<SignUpBloc>().add(SignInWithGoogle()),
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
