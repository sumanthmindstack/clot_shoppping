part of 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading());
  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(UnAuthorized());
  }
}
