import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/app_error.dart';
import '../../../domain/entities/mfd_patch_entity.dart';
import '../../../domain/entities/params/contact_details_params.dart';
import '../../../domain/usecase/contact_details_usecase.dart';

part 'contact_details_state.dart';

@injectable
class ContactDetailsCubit extends Cubit<ContactDetailsState> {
  final ContactDetailsUsecase _contactDetailsUsecase;

  ContactDetailsCubit(this._contactDetailsUsecase)
      : super(ContactDetailsInitialState());

  Future<void> fetchContactDetails({
    required String id,
    int? primaryMobile,
    int? primaryLandline,
    String? primaryEmail,
    int? alternateMobile,
    String? alternateEmail,
    int? communicationPrimaryMobile,
    int? communicationPrimaryLandline,
    String? communicationPrimaryEmail,
    int? communicationAlternateMobile,
    String? communicationAlternateEmail,
  }) async {
    emit(ContactDetailsLoadingState());

    final params = ContactDetailsParams(
      id: id,
      primaryMobile: primaryMobile!,
      primaryLandline: primaryLandline!,
      primaryEmail: primaryEmail!,
      alternateMobile: alternateMobile!,
      alternateEmail: alternateEmail!,
      communicationPrimaryMobile: communicationPrimaryMobile!,
      communicationPrimaryLandline: communicationPrimaryLandline!,
      communicationPrimaryEmail: communicationPrimaryEmail!,
      communicationAlternateMobile: communicationAlternateMobile!,
      communicationAlternateEmail: communicationAlternateEmail!,
    );

    final response = await _contactDetailsUsecase(params);

    response.fold(
      (l) => emit(ContactDetailsFailureState(
          errorType: l.errorType, errorMessage: l.error)),
      (r) => emit(ContactDetailsSuccessState(r)),
    );
  }
}
