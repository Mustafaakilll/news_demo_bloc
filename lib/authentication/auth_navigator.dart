import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) => Navigator(
        pages: [],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}
