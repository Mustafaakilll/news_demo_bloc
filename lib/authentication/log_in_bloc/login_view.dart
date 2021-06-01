import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      create: (context) => LoginBloc(context.read<AuthRepository>()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _loginForm(),
              _googleSignIn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emailField(),
              _passwordField(),
              _submitButton(),
              _signUpButton(),
            ],
          ),
        );
      },
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailure) {
          _snackBarMessenger(formStatus.exception.toString(), context);
        } else if (formStatus is SubmissionSuccess) {
          _snackBarMessenger('Hos Geldiniz ${formStatus.user!.email}', context);
        }
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) => context.read<LoginBloc>().state.isValidEmail
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
          validator: (value) => context.read<LoginBloc>().state.isValidPassword
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
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => context.read<LoginBloc>().add(LoginSubmitted()),
          child: const Text('Giris Yap'),
        );
      },
    );
  }

  Widget _signUpButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {},
          child: Text(
            'Hemen Kayit Ol',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.blue),
          ),
        );
      },
    );
  }

  Widget _googleSignIn() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => context.read<LoginBloc>().add(LoginWithGoogle()),
          child: const Text('Google ile giris yap'),
        );
      },
    );
  }

  void _snackBarMessenger(String text, BuildContext context) {
    final snackBar = SnackBar(
        content: Text(
          text,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Theme.of(context).backgroundColor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
