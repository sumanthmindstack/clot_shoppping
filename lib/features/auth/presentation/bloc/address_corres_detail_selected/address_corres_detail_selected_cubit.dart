import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'address_corres_detail_selected_state.dart';

@injectable
class AddressCorresDetailSelectedCubit extends Cubit<bool> {
  AddressCorresDetailSelectedCubit() : super(false);
  void isSelectedAddress(bool isSelected) {
    final currentState = isSelected;
    print("isSelectedAddress: $currentState");
    emit(currentState);
  }
}
