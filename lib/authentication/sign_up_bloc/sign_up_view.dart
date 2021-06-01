import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_demo_bloc/authentication/sign_up_bloc/sign_up_event.dart';
import 'package:news_demo_bloc/authentication/sign_up_bloc/sign_up_state.dart';

import '../auth_repository.dart';
import 'sign_up_bloc.dart';

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(context.read<AuthRepository>()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _signUpForm(),
              _googleSignIn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailField(),
          _passwordField(),
          _submitButton(),
          _signInButton(),
        ],
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          validator: (value) => context.read<SignUpBloc>().state.isValidEmail
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
          validator: (value) => context.read<SignUpBloc>().state.isValidPassword
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
          onPressed: () => context.read<SignUpBloc>().add(SignUpSubmitted()),
          child: const Text('Giris Yap'),
        );
      },
    );
  }

  Widget _signInButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {},
          child: Text(
            'Hemen Giris Yap',
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () => context.read<SignUpBloc>().add(SignInWithGoogle()),
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
