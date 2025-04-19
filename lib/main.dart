import 'package:auto_route/auto_route.dart';
import 'package:clot_store/firebase_options.dart';
import 'package:clot_store/presentation/splash/bloc/splash_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const CShopingApp());
}

final _appRouter = AppRouter();

class CShopingApp extends StatelessWidget {
  const CShopingApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return BlocProvider(
          create: (context) => SplashCubit()..appStarted(),
          child: MaterialApp.router(
              themeMode: ThemeMode.dark,
              theme: ThemeData.dark(),
              routerConfig: _appRouter.config(
                navigatorObservers: () => [AutoRouteObserver()],
              )),
        );
      },
    );
  }
}
