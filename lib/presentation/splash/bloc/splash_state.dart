import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_cubit.dart';

abstract class SplashState {}

class SplashLoading extends SplashState {}

class Authorized extends SplashState {}

class UnAuthorized extends SplashState {}
