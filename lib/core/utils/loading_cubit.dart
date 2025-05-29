import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoadingCubit extends Cubit<bool> {
  LoadingCubit() : super(false);

  void show() => emit(true);

  void hide() => emit(false);
}
