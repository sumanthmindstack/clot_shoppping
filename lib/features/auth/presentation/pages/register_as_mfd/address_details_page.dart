import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/validator.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/find_one/find_one_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/mfd_patch_address_details/mfd_patch_address_details_cubit.dart';
import 'package:maxwealth_distributor_app/features/auth/presentation/bloc/pass_id_pagetopage/pass_id_pagetopage_cubit.dart';
import 'package:maxwealth_distributor_app/widgets/custom_check_box.dart';
import 'package:maxwealth_distributor_app/widgets/text_field_widget.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../../widgets/custom_loading_widget.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../../widgets/submit_button_widget.dart';
import '../../../domain/entities/find_one_entity.dart';
import '../../bloc/address_corres_detail_selected/address_corres_detail_selected_cubit.dart';
import '../../bloc/mfd_flow_check/mfd_flow_check_cubit.dart';

class AddressDetailsPage extends StatefulWidget {
  final PageController? pageController;

  const AddressDetailsPage({super.key, this.pageController});

  @override
  State<AddressDetailsPage> createState() => _AddressDetailsPageState();
}

class _AddressDetailsPageState extends State<AddressDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _address1PermanentAddressController =
      TextEditingController();
  final TextEditingController _address2PermanentAddressController =
      TextEditingController();
  final TextEditingController _address3PermanentAddressController =
      TextEditingController();
  final TextEditingController _countryPermanentAddressController =
      TextEditingController();
  final TextEditingController _statePermanentAddressController =
      TextEditingController();
  final TextEditingController _pincodePermanentAddressController =
      TextEditingController();
  final TextEditingController _cityPermanentAddressController =
      TextEditingController();
  final TextEditingController _areaPermanentAddressController =
      TextEditingController();

  final TextEditingController _address1CommunicationAddressController =
      TextEditingController();
  final TextEditingController _address2CommunicationAddressController =
      TextEditingController();
  final TextEditingController _address3CommunicationAddressController =
      TextEditingController();
  final TextEditingController _countryCommunicationAddressController =
      TextEditingController();
  final TextEditingController _stateCommunicationAddressController =
      TextEditingController();
  final TextEditingController _pincodeCommunicationAddressController =
      TextEditingController();
  final TextEditingController _cityCommunicationAddressController =
      TextEditingController();
  final TextEditingController _areaCommunicationAddressController =
      TextEditingController();
  bool _isSameAsCorrespondence = false;
  @override
  void initState() {
    final id = context.read<PassIdPagetopageCubit>().getId;
    context.read<FindOneCubit>().findOne(id: id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindOneCubit, FindOneState>(
      listener: (context, state) {
        if (state is FindOneSuccessState) {
          _setIntialState(state.findOneEntity);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 20),
                  CustomCheckBox(
                    title: "Same as Correspondence Details",
                    onChanged: (value) {
                      context
                          .read<AddressCorresDetailSelectedCubit>()
                          .isSelectedAddress(value);
                      _isSameAsCorrespondence = value;
                      value
                          ? _copyPermanentToCommunicationAddress(true)
                          : _copyPermanentToCommunicationAddress(false);
                    },
                  ),
                  const SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _address1PermanentAddressField(context),
                          const SizedBox(height: 15),
                          _address2PermanentAddressField(context),
                          const SizedBox(height: 15),
                          _address3PermanentAddressField(context),
                          const SizedBox(height: 15),
                          _countryPermanentAddressText(context),
                          const SizedBox(height: 15),
                          _statePermanentAddressText(context),
                          const SizedBox(height: 15),
                          _pincodePermanentAddressText(context),
                          const SizedBox(height: 15),
                          _cityPermanentAddressText(context),
                          const SizedBox(height: 15),
                          _areaPermanentAddressText(context),
                          const SizedBox(height: 15),
                          _communicationAddressDetailsText(context),
                          const SizedBox(height: 15),
                          _address1CommunicationAddressField(context),
                          const SizedBox(height: 15),
                          _address2CommunicationAddressField(context),
                          const SizedBox(height: 15),
                          _address3CommunicationAddressField(context),
                          const SizedBox(height: 15),
                          _countryCommunicationAddressText(context),
                          const SizedBox(height: 15),
                          _stateCommunicationAddressText(context),
                          const SizedBox(height: 15),
                          _pincodeCommunicationAddressText(context),
                          const SizedBox(height: 15),
                          _cityCommunicationAddressText(context),
                          const SizedBox(height: 15),
                          _areaCommunicationAddressText(context),
                          const SizedBox(height: 15),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SubmitButtonWidget(
                                      label: "Prev",
                                      onPressed: () {
                                        widget.pageController!.jumpToPage(2);
                                        context
                                            .read<MfdFlowCheckCubit>()
                                            .setMFDRegistrationFlowCheck(2);
                                      },
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: BlocConsumer<
                                        MfdPatchAddressDetailsCubit,
                                        MfdPatchAddressDetailsState>(
                                      listener: (context, state) {
                                        if (state
                                            is MfdPatchAddressDetailsSuccessState) {
                                          _showSnackSuccess(context);
                                        } else if (state
                                            is MfdPatchAddressDetailsFailureState) {
                                          _showSnackFailure(context,
                                              state.errorMessage.toString());
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state
                                            is MfdPatchAddressDetailsLoadingState) {
                                          return const CustomLoadingButton(
                                              color: AppColors.primaryColor);
                                        }
                                        return SubmitButtonWidget(
                                          label: "Next Step",
                                          onPressed: () {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              final id = context
                                                  .read<PassIdPagetopageCubit>()
                                                  .getId;
                                              context
                                                  .read<
                                                      MfdPatchAddressDetailsCubit>()
                                                  .patchMFDAddressDetails(
                                                    id: id,
                                                    address1:
                                                        _address1PermanentAddressController
                                                            .text,
                                                    address2:
                                                        _address2PermanentAddressController
                                                            .text,
                                                    address3:
                                                        _address3PermanentAddressController
                                                            .text,
                                                    area:
                                                        _areaPermanentAddressController
                                                            .text,
                                                    city:
                                                        _cityPermanentAddressController
                                                            .text,
                                                    state:
                                                        _statePermanentAddressController
                                                            .text,
                                                    country:
                                                        _countryPermanentAddressController
                                                            .text,
                                                    pincode:
                                                        _pincodePermanentAddressController
                                                            .text,
                                                    communicationAddress1:
                                                        _address1CommunicationAddressController
                                                            .text,
                                                    communicationAddress2:
                                                        _address2CommunicationAddressController
                                                            .text,
                                                    communicationAddress3:
                                                        _address3CommunicationAddressController
                                                            .text,
                                                    communicationArea:
                                                        _areaCommunicationAddressController
                                                            .text,
                                                    communicationCity:
                                                        _cityCommunicationAddressController
                                                            .text,
                                                    communicationState:
                                                        _stateCommunicationAddressController
                                                            .text,
                                                    communicationCountry:
                                                        _countryCommunicationAddressController
                                                            .text,
                                                    communicationPincode:
                                                        _pincodeCommunicationAddressController
                                                            .text,
                                                  );
                                            }
                                          },
                                          color: AppColors.primaryColor,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _communicationAddressDetailsText(BuildContext context) {
    return const Text(
      "Communication Address Details",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _address1PermanentAddressField(BuildContext context) {
    return TextFieldWidget(
      labelText: "Address 1",
      hintText: "Enter Address 1",
      validator: Validators.validateAddressField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s\.,\-#/]')),
      ],
      controller: _address1PermanentAddressController,
    );
  }

  Widget _address2PermanentAddressField(BuildContext context) {
    return TextFieldWidget(
      labelText: "Address 2",
      hintText: "Enter Address 2",
      validator: Validators.validateAddressField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s\.,\-#/]')),
      ],
      controller: _address2PermanentAddressController,
    );
  }

  Widget _address3PermanentAddressField(BuildContext context) {
    return TextFieldWidget(
      labelText: "Address 3",
      hintText: "Enter Address 3",
      validator: Validators.validateAddressField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s\.,\-#/]')),
      ],
      controller: _address3PermanentAddressController,
    );
  }

  Widget _countryPermanentAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "Country",
      hintText: "Enter Country",
      validator: Validators.validateCountryField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      controller: _countryPermanentAddressController,
    );
  }

  Widget _statePermanentAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "State",
      hintText: "Enter State",
      validator: Validators.validateStateField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      controller: _statePermanentAddressController,
    );
  }

  Widget _pincodePermanentAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "Pincode",
      hintText: "Enter Pincode",
      validator: Validators.validatePinCode,
      isNumberOrString: TextInputType.number,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      controller: _pincodePermanentAddressController,
    );
  }

  Widget _cityPermanentAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "City",
      hintText: "Enter City",
      validator: Validators.validateCity,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      controller: _cityPermanentAddressController,
    );
  }

  Widget _areaPermanentAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "Area",
      hintText: "Enter Area",
      validator: Validators.validateArea,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      controller: _areaPermanentAddressController,
    );
  }

  Widget _address1CommunicationAddressField(BuildContext context) {
    return TextFieldWidget(
      labelText: "Address 1",
      hintText: "Enter Address 1",
      validator: Validators.validateAddressField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s\.,\-#/]')),
      ],
      controller: _address1CommunicationAddressController,
    );
  }

  Widget _address2CommunicationAddressField(BuildContext context) {
    return TextFieldWidget(
      labelText: "Address 2",
      hintText: "Enter Address 2",
      validator: Validators.validateAddressField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s\.,\-#/]')),
      ],
      controller: _address2CommunicationAddressController,
    );
  }

  Widget _address3CommunicationAddressField(BuildContext context) {
    return TextFieldWidget(
      labelText: "Address 3",
      hintText: "Enter Address 3",
      validator: Validators.validateAddressField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s\.,\-#/]')),
      ],
      controller: _address3CommunicationAddressController,
    );
  }

  Widget _countryCommunicationAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "Country",
      hintText: "Enter Country",
      validator: Validators.validateCountryField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      controller: _countryCommunicationAddressController,
    );
  }

  Widget _stateCommunicationAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "State",
      hintText: "Enter State",
      validator: Validators.validateStateField,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      controller: _stateCommunicationAddressController,
    );
  }

  Widget _pincodeCommunicationAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "Pincode",
      hintText: "Enter Pincode",
      validator: Validators.validatePinCode,
      isNumberOrString: TextInputType.number,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(6),
      ],
      controller: _pincodeCommunicationAddressController,
    );
  }

  Widget _cityCommunicationAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "City",
      hintText: "Enter City",
      validator: Validators.validateCity,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      controller: _cityCommunicationAddressController,
    );
  }

  Widget _areaCommunicationAddressText(BuildContext context) {
    return TextFieldWidget(
      labelText: "Area",
      hintText: "Enter Area",
      validator: Validators.validateArea,
      isNumberOrString: TextInputType.streetAddress,
      onChanged: (value) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      ],
      controller: _areaCommunicationAddressController,
    );
  }

  void _showSnackSuccess(BuildContext context) {
    widget.pageController!.jumpToPage(4);
    context.read<MfdFlowCheckCubit>().setMFDRegistrationFlowCheck(3);
    CustomSnackBar.show(
      context,
      message: "Address Details Uploaded Successful",
      backgroundColor: AppColors.primaryColor,
      borderRadius: 16,
    );
  }

  void _showSnackFailure(BuildContext context, String errorMessage) {
    CustomSnackBar.show(
      context,
      message: errorMessage,
      backgroundColor: AppColors.errorRed,
      borderRadius: 16,
    );
  }

  void _copyPermanentToCommunicationAddress([bool? shouldCopy]) {
    _address1CommunicationAddressController.text =
        shouldCopy == true ? _address1PermanentAddressController.text : '';
    _address2CommunicationAddressController.text =
        shouldCopy == true ? _address2PermanentAddressController.text : '';
    _address3CommunicationAddressController.text =
        shouldCopy == true ? _address3PermanentAddressController.text : '';
    _countryCommunicationAddressController.text =
        shouldCopy == true ? _countryPermanentAddressController.text : '';
    _stateCommunicationAddressController.text =
        shouldCopy == true ? _statePermanentAddressController.text : '';
    _pincodeCommunicationAddressController.text =
        shouldCopy == true ? _pincodePermanentAddressController.text : '';
    _cityCommunicationAddressController.text =
        shouldCopy == true ? _cityPermanentAddressController.text : '';
    _areaCommunicationAddressController.text =
        shouldCopy == true ? _areaPermanentAddressController.text : '';
  }

  Future<void> _setIntialState(FindOneEntity state) async {
    _address1PermanentAddressController.text = state.address1 ?? '';
    _address2PermanentAddressController.text = state.address2 ?? '';
    _address3PermanentAddressController.text = state.address3 ?? '';
    _countryPermanentAddressController.text = state.country ?? '';
    _statePermanentAddressController.text = state.state ?? '';
    _pincodePermanentAddressController.text = state.pincode ?? '';
    _cityPermanentAddressController.text = state.city ?? '';
    _areaPermanentAddressController.text = state.area ?? '';
    _address1CommunicationAddressController.text = state.address1 ?? '';
    _address2CommunicationAddressController.text = state.address2 ?? '';
    _address3CommunicationAddressController.text = state.address3 ?? '';
    _countryCommunicationAddressController.text = state.country ?? '';
    _stateCommunicationAddressController.text = state.state ?? '';
    _pincodeCommunicationAddressController.text = state.pincode ?? '';
    _cityCommunicationAddressController.text = state.city ?? '';
    _areaCommunicationAddressController.text = state.area ?? '';
  }
}
