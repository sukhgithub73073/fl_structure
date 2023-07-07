import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_structure/bussiness_logic/app_bloc_provider.dart';
import 'package:fl_structure/bussiness_logic/blocs/network_bloc/network_bloc.dart';
import 'package:fl_structure/bussiness_logic/injector.dart';
import 'package:fl_structure/screens/splash_screen.dart';
import 'package:fl_structure/utils/no_internet_connection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;

  }

  await Hive.initFlutter();


  await AppInjector.init(appRunner: () => runApp(const MyApplicationApp()));
}
class MyApplicationApp extends StatelessWidget {
  const MyApplicationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyApplicationAppContact();
  }
}

class MyApplicationAppContact extends StatefulWidget {
  const MyApplicationAppContact({super.key});

  @override
  State<MyApplicationAppContact> createState() => _MyApplicationAppContactState();
}

class _MyApplicationAppContactState extends State<MyApplicationAppContact> {
  final botToastBuilder = BotToastInit();
  OverlaySupportEntry? noInternet;
  OverlaySupportEntry? haveInternet;
  GlobalKey<NavigatorState> navKey = GetIt.I.get<GlobalKey<NavigatorState>>();

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: BlocProvider(
        create: (context) =>
        NetworkBloc()
          ..add(ListenConnection()),
        child:  BlocConsumer<NetworkBloc, NetworkState>(
          listener: networkListener,
          builder: (context, networkState) {
            return AppBlocProvider(
              child: GetMaterialApp(
                navigatorKey: navKey,
                debugShowCheckedModeBanner: false,
                title: 'Community Watcher',
                home: const SplashScreen(),
                builder: (context, child) {
                  child = botToastBuilder(context, child);
                  return child;
                },
              ),
            );
          },
        ),
      ),
    );
  }
  Future<void> networkListener(BuildContext context, NetworkState state) async {
    /// When restored internet connection
    if (state is NetworkLoaded) {
      noInternet?.dismiss();
    }

    /// When no internet connection
    if (state is NetworkError) {
      haveInternet?.dismiss();
      noInternet = showOverlayNotification(
            (c) => const NoConnectionDialog(),
        duration: const Duration(seconds: 300),
        position: NotificationPosition.bottom,
        context: context,
      );
    }
  }
}
