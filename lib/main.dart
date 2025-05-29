import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:maxwealth_distributor_app/app.dart';
import 'core/entities/user_local.dart';
import 'core/resource/bloc_observer.dart';
import 'get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter("data");
  Hive.registerAdapter(UserLocalAdapter());
  if (!Hive.isBoxOpen('userBox')) {
    await Hive.openBox<UserLocal>('userBox');
  }
  runApp(const MaxWealthDistributor());
}
