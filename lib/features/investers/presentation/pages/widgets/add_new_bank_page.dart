import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/validator.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import 'package:maxwealth_distributor_app/widgets/custom_loading_widget.dart';
import 'package:maxwealth_distributor_app/widgets/custom_snackbar.dart';
import 'package:maxwealth_distributor_app/widgets/submit_button_widget.dart';
import 'package:maxwealth_distributor_app/widgets/text_field_widget.dart';

import '../../../domain/entity/params/investor_profile_data_params.dart';
import '../../bloc/add_new_bank/add_new_bank_cubit.dart';
import '../../bloc/investor_profile_data/investor_profile_data_cubit.dart';

@RoutePage()
class AddNewBankPage extends StatefulWidget {
  final int userId;
  const AddNewBankPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<AddNewBankPage> createState() => _AddNewBankPageState();
}

class _AddNewBankPageState extends State<AddNewBankPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _accountHolderNameController =
      TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();

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
            'Add New Bank',
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'Enter your bank details below',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey,
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
                  _buildFormTitle(),
                  const SizedBox(height: 24),
                  _buildAccountHolderNameField(),
                  const SizedBox(height: 16),
                  _buildAccountNumberField(),
                  const SizedBox(height: 16),
                  _buildIfscField(),
                  const SizedBox(height: 16),
                  _buildBankNameField(),
                  const SizedBox(height: 32),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormTitle() {
    return Text(
      'Bank Details',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildAccountHolderNameField() {
    return TextFieldWidget(
      labelText: "Account Holder Name *",
      controller: _accountHolderNameController,
      validator: Validators.validateNameFields,
      isNumberOrString: TextInputType.name,
      onChanged: (val) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]")),
      ],
    );
  }

  Widget _buildAccountNumberField() {
    return TextFieldWidget(
      labelText: "Account Number *",
      controller: _accountNumberController,
      validator: Validators.validateBankAccountNumber,
      isNumberOrString: TextInputType.number,
      onChanged: (val) {},
      textInputFormat: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(18),
      ],
    );
  }

  Widget _buildIfscField() {
    return TextFieldWidget(
      labelText: "IFSC Code *",
      controller: _ifscController,
      validator: Validators.validateIFSCCode,
      textCapitalization: TextCapitalization.characters,
      onChanged: (val) {},
      isNumberOrString: TextInputType.text,
      textInputFormat: [
        FilteringTextInputFormatter.allow(
          RegExp(r'^[A-Z]{0,4}0{0,1}[A-Z0-9]{0,6}$'),
        ),
      ],
    );
  }

  Widget _buildBankNameField() {
    return TextFieldWidget(
      labelText: "Bank Name *",
      controller: _bankNameController,
      validator: Validators.validateBankAccountName,
      isNumberOrString: TextInputType.text,
      onChanged: (val) {},
      textInputFormat: [
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9 .'-]")),
        LengthLimitingTextInputFormatter(50),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SubmitButtonWidget(
            label: "Cancel",
            onPressed: () => Navigator.pop(context),
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: BlocConsumer<AddNewBankCubit, AddNewBankState>(
            listener: (context, state) {
              if (state is AddNewBankSuccessState) {
                CustomSnackBar.show(context,
                    backgroundColor: AppColors.primaryColor,
                    message: "Add New Bank Successful");
                context.popRoute();
                context
                    .read<InvesterProfileDataCubit>()
                    .fetchInvestorProfileData(
                        params: InvestorProfileDataParams.withUserIdFilter(
                            widget.userId));
              }
              if (state is AddNewBankFailureState) {
                CustomSnackBar.show(context,
                    backgroundColor: AppColors.errorRed,
                    message: state.errorMessage.toString());
              }
            },
            builder: (context, state) {
              if (state is AddNewBankLoadingState) {
                return const CustomLoadingButton(color: AppColors.primaryColor);
              }
              return SubmitButtonWidget(
                label: "Add Bank",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AddNewBankCubit>().addNewBank(
                        accountHolderName: _accountHolderNameController.text,
                        accountNumber: _accountNumberController.text,
                        bankName: _bankNameController.text,
                        ifscCode: _ifscController.text,
                        userId: widget.userId);
                  }
                },
                color: AppColors.primaryColor,
              );
            },
          ),
        ),
      ],
    );
  }
}
