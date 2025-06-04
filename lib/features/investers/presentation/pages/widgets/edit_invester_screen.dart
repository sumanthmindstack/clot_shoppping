import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/formatters.dart';
import 'package:maxwealth_distributor_app/common/validator.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'package:maxwealth_distributor_app/widgets/custom_date_picker.dart';
import 'package:maxwealth_distributor_app/widgets/custom_loading_widget.dart';
import 'package:maxwealth_distributor_app/widgets/custom_snackbar.dart';
import 'package:maxwealth_distributor_app/widgets/submit_button_widget.dart';
import 'package:maxwealth_distributor_app/widgets/text_field_widget.dart';
import '../../bloc/edit_invester_details/edit_invester_details_cubit.dart';

class EditInvesterScreen extends StatefulWidget {
  final String mobileNumber;
  final String email;
  final String date;
  final String pan;
  final int userId;
  const EditInvesterScreen(
      {super.key,
      required this.mobileNumber,
      required this.email,
      required this.date,
      required this.pan,
      required this.userId});

  @override
  State<EditInvesterScreen> createState() => _EditInvesterScreenState();
}

class _EditInvesterScreenState extends State<EditInvesterScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    intitialCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 5),
            _buildSubTitle(),
            const SizedBox(height: 16),
            _buildFormCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Edit Investor Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'test (PAN: ${widget.pan})',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Investor Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    labelText: "Mobile Number",
                    validator: Validators.validateMobileNumber,
                    isNumberOrString: TextInputType.number,
                    onChanged: (value) {},
                    textInputFormat: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    controller: _mobileController,
                  ),
                  const SizedBox(height: 16),
                  TextFieldWidget(
                    labelText: "Email Address",
                    validator: Validators.validateEmail,
                    isNumberOrString: TextInputType.emailAddress,
                    onChanged: (value) {},
                    textInputFormat: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z0-9@._\-]'),
                      ),
                    ],
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  CustomDatePicker(
                    initialDate: DateTime.parse(_dobController.text),
                    labelText: "Date of Birth",
                    hintText: "dd-mm-yyyy",
                    onDatePicked: (pickedDate) {
                      _dobController.text = Formatters().formatDate(pickedDate);
                    },
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: SubmitButtonWidget(
                          label: "Cancel",
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: BlocConsumer<EditInvesterDetailsCubit,
                            EditInvesterDetailsState>(
                          listener: (context, state) {
                            if (state is EditInvesterDetailsSuccessState) {
                              CustomSnackBar.show(context,
                                  backgroundColor: AppColors.primaryBlue,
                                  message:
                                      "Investor Details Updated Successful");
                            }
                          },
                          builder: (context, state) {
                            if (state is EditInvesterDetailsLoadingState) {
                              return const CustomLoadingButton(
                                  color: AppColors.primaryColor);
                            }

                            if (state is EditInvesterDetailsFailureState) {
                              CustomSnackBar.show(context,
                                  backgroundColor: AppColors.errorRed,
                                  message: state.errorMessage.toString());
                            }
                            return SubmitButtonWidget(
                              label: "     Save\n Changes",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<EditInvesterDetailsCubit>()
                                      .editDetails(userId: widget.userId);
                                }
                              },
                              color: AppColors.primaryColor,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void intitialCall() {
    _mobileController.text = widget.mobileNumber;
    _emailController.text = widget.email;
    _dobController.text = widget.date.isNotEmpty == true
        ? widget.date
        : DateTime.now().toUtc().toIso8601String();
  }
}
