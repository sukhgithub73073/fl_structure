import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  final bool lazy;

  const AppBlocProvider({
    Key? key,
    required this.child,
    this.lazy = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(lazy: lazy, create: (_) => LoginBloc()),

],
      child: child,
    );
  }
}
