import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/mfd_patch_entity.dart';
import '../../../domain/entities/params/address_details_params.dart';
import '../../../domain/usecase/mfd_patch_address_details_usecase.dart';

part 'mfd_patch_address_details_state.dart';

@injectable
class MfdPatchAddressDetailsCubit extends Cubit<MfdPatchAddressDetailsState> {
  final MfdPatchAddressDetailsUsecase _mfdPatchAddressDetailsUsecase;
  MfdPatchAddressDetailsCubit(this._mfdPatchAddressDetailsUsecase)
      : super(MfdPatchAddressDetailsInitialState());
  void patchMFDAddressDetails({
    required int id,
    required String address1,
    required String address2,
    required String address3,
    required String area,
    required String city,
    required String state,
    required String country,
    required String pincode,
    required String communicationAddress1,
    required String communicationAddress2,
    required String communicationAddress3,
    required String communicationArea,
    required String communicationCity,
    required String communicationState,
    required String communicationCountry,
    required String communicationPincode,
  }) async {
    emit(MfdPatchAddressDetailsLoadingState());

    final response = await _mfdPatchAddressDetailsUsecase(AddressDetailsParams(
        id: id,
        address1: address1,
        address2: address2,
        address3: address3,
        area: area,
        city: city,
        state: state,
        country: country,
        pincode: pincode,
        communicationAddress1: communicationAddress1,
        communicationAddress2: communicationAddress2,
        communicationAddress3: communicationAddress3,
        communicationArea: communicationArea,
        communicationCity: communicationCity,
        communicationState: communicationState,
        communicationCountry: communicationCountry,
        communicationPincode: communicationPincode));

    response.fold(
      (l) => emit(
        MfdPatchAddressDetailsFailureState(
            errorType: l.errorType, errorMessage: l.error),
      ),
      (r) => emit(MfdPatchAddressDetailsSuccessState(r)),
    );
  }
}
