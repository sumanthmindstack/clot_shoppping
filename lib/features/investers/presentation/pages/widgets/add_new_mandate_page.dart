import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/features/investers/domain/entity/params/post_bank_mandates_params.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/bloc/get_all_bank/get_all_bank_cubit.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/bloc/get_bank_mandates/get_bank_mandates_cubit.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/bloc/post_bank_mandates/post_bank_mandates_state.dart';
import 'package:maxwealth_distributor_app/widgets/custom_dropdown_field.dart';
import 'package:maxwealth_distributor_app/widgets/custom_loading_widget.dart';
import 'package:maxwealth_distributor_app/widgets/custom_snackbar.dart';
import 'package:maxwealth_distributor_app/widgets/text_field_widget.dart';

import '../../../../../common/validator.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../widgets/submit_button_widget.dart';
import '../../bloc/post_bank_mandates/post_bank_mandates_cubit.dart';

@RoutePage()
class AddNewMandatePage extends StatefulWidget {
  final int userId;
  const AddNewMandatePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<AddNewMandatePage> createState() => _AddNewMandatePageState();
}

class _AddNewMandatePageState extends State<AddNewMandatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mandateLimitController = TextEditingController();
  String? selectedBank;
  String selectedMandateType = 'E_MANDATE';

  final List<String> bankList = ['SBI', 'HDFC', 'ICICI', 'Axis'];
  final List<String> mandateTypes = ['E_MANDATE', 'PHYSICAL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildHeader(context),
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
            'New Mandate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
                border: Border.all(color: Colors.grey.shade300, width: 1.2),
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
                  _buildBankDropdown(),
                  const SizedBox(height: 16),
                  _buildMandateTypeDropdown(),
                  const SizedBox(height: 16),
                  _buildMandateLimitField(),
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
      'Mandate Details',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }

  Widget _buildBankDropdown() {
    return BlocConsumer<GetAllBankCubit, GetAllBankState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetBankMandatesSuccessState) {
          // final List<String> items = state;
        }
        return CustomDropdownField(
          dropdowns: [
            DropdownConfig("Select Bank*", ["Bank Of Baroda", "HDFC"]),
          ],
          onSelectionChanged: (value) {},
        );
      },
    );
  }

  Widget _buildMandateTypeDropdown() {
    return CustomDropdownField(
      dropdowns: [
        DropdownConfig("Select Mandate Type*", ["E_MANDATE"]),
      ],
      onSelectionChanged: (value) {},
    );
  }

  Widget _buildMandateLimitField() {
    return TextFieldWidget(
      onChanged: (value) {},
      labelText: 'Mandate Limit *',
      controller: _mandateLimitController,
      isNumberOrString: TextInputType.number,
      hintText: 'Mandate Limit',
      validator: Validators.validateMandateLimit,
      textInputFormat: [FilteringTextInputFormatter.digitsOnly],
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
          child: BlocConsumer<PostBankMandatesCubit, PostBankMandatesState>(
            listener: (context, state) {
              if (state is PostBankMandatesFailure) {
                CustomSnackBar.show(context,
                    backgroundColor: AppColors.errorRed,
                    message: state.errorMessage.toString());
              }
            },
            builder: (context, state) {
              if (state is PostBankMandatesLoading) {
                return const CustomLoadingButton(color: AppColors.primaryColor);
              }
              return SubmitButtonWidget(
                label: "Next Step",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<PostBankMandatesCubit>().postBankMandate(
                        PostBankMandatesParams(
                            bankId: 0,
                            mandateLimit:
                                int.parse(_mandateLimitController.text),
                            mandateType: selectedMandateType));
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
