import 'dart:async';
import 'package:fl_structure/bussiness_logic/blocs/toggle_blocs/auth_screen_toggle_blocs.dart';
import 'package:fl_structure/screens/auth_screens/login_screen.dart';
import 'package:fl_structure/utils/all_getter.dart';
import 'package:fl_structure/utils/assets_paths.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getAuthRepo.getDeviceId();
    context.read<AnimatedContainerToggleBloc>().add(false);
    context.read<AnimatedOpacityToggleBloc>().add(true);
    super.initState();
    Timer(const Duration(milliseconds: 400), () {
      context.read<AnimatedOpacityToggleBloc>().add(false);
      Timer(const Duration(milliseconds: 600), () async {
        context.read<AnimatedContainerToggleBloc>().add(true);
        context.read<AnimatedOpacityToggleBloc>().add(true);
      });
      Timer(const Duration(seconds: 2), () async {
        pushTo(context, LoginScreen()) ;

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetsPath.splashScreenImage,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primary.withOpacity(0.4),
                    primary.withOpacity(0.4),
                    primary.withOpacity(0.6),
                    primary.withOpacity(0.8)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.1, 0.2, 1],
                ),
              ),
              child: Center(
                child: BlocBuilder<AnimatedContainerToggleBloc, bool>(
                  builder: (context, state) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.linearToEaseOut,
                      height: state ? screenHeight(context) * 0.12 : 0,
                      child: Image.asset(
                        AssetsPath.appLogo,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
