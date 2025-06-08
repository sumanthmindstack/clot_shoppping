import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maxwealth_distributor_app/common/formatters.dart';
import 'package:maxwealth_distributor_app/config/routes/app_router.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/bloc/change_primary_bank/change_primary_bank_cubit.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/pages/widgets/invester_tabs/holdings_tab.dart';
import 'package:maxwealth_distributor_app/features/investers/presentation/pages/widgets/invester_tabs/portfolio_summary_tab.dart';
import 'package:maxwealth_distributor_app/themes/app_colors.dart';
import '../../../../../widgets/custom_small_textbutton.dart';
import '../../../../../widgets/custom_snackbar.dart';
import '../../../../../widgets/custom_tab_view.dart';
import '../../../domain/entity/get_invester_list_entitty.dart';
import '../../../domain/entity/investor_profile_data_entity.dart';
import '../../../domain/entity/params/investor_profile_data_params.dart';
import '../../bloc/investor_profile_data/investor_profile_data_cubit.dart';
import 'edit_invester_screen.dart';
import 'invester_tabs/account_summary_tab.dart';
import 'invester_tabs/transaction_tab.dart';
import 'invester_tabs/user_goals_tab.dart';

@RoutePage()
class InvestorProfilePage extends StatefulWidget {
  final int userId;
  final int index;
  final List<BankDetailEntity> bankId;

  const InvestorProfilePage({
    super.key,
    required this.userId,
    required this.index,
    required this.bankId,
  });

  @override
  State<InvestorProfilePage> createState() => _InvestorProfilePageState();
}

class _InvestorProfilePageState extends State<InvestorProfilePage> {
  @override
  void initState() {
    context.read<InvesterProfileDataCubit>().fetchInvestorProfileData(
        params: InvestorProfileDataParams.withUserIdFilter(widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child:
              BlocConsumer<InvesterProfileDataCubit, InvesterProfileDataState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is InvesterProfileDataLoadingState) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              }
              if (state is InvesterProfileDataSuccessState) {
                InvestorProfileDataEntity data =
                    state.investorProfileDataEntity[0];
                return Column(
                  children: [
                    _appbarData(context),
                    const SizedBox(height: 10),
                    _buildProfileHeader(data),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Personal Information'),
                    const SizedBox(height: 12),
                    _buildProfileCard(data),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Address Details'),
                    const SizedBox(height: 12),
                    _buildAddressCard(data),
                    const SizedBox(height: 16),
                    _buildSectionTitle('Bank Accounts'),
                    const SizedBox(height: 12),
                    _buildBankCard(data),
                    const SizedBox(height: 25),
                    _tabs(context, data),
                    const SizedBox(height: 15),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _appbarData(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColors.black20,
          ),
        ),
        const Spacer(),
        const Text(
          'Investor Profile',
          style: TextStyle(
            color: AppColors.black20,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const Spacer(),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildProfileHeader(InvestorProfileDataEntity data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black20,
              border: Border.all(color: AppColors.black20, width: 2),
            ),
            child:
                const Icon(Icons.person, size: 65, color: AppColors.pureWhite),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.user?.username ?? "---",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  "${data.fullName}(As per PAN)",
                  style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Active Investor',
                    style: TextStyle(
                      color: Color(0xFF027A48),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.pureWhite,
              ),
              child: const Icon(Icons.edit,
                  size: 18, color: AppColors.primaryColor),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditInvesterScreen(
                    userId: data.userId ?? 0,
                    pan: data.pan ?? "---",
                    date: data.dateOfBirth ?? "",
                    email: data.user?.email ?? "",
                    mobileNumber: data.user?.mobile ?? "",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildProfileCard(InvestorProfileDataEntity data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _infoRow("PAN Number", data.pan ?? "---", Icons.credit_card),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF3F4F6)),
          _infoRow(
              "Aadhaar Number", data.aadhaarNumber ?? "---", Icons.fingerprint),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF3F4F6)),
          _infoRow("Contact Number", "+91 ${data.user?.mobile ?? "---"}",
              Icons.phone),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF3F4F6)),
          _infoRow("Email Address", data.user?.email ?? "---", Icons.email),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF3F4F6)),
          _infoRow(
              "Date of Birth",
              Formatters().formatIsoToNormalDate(data.dateOfBirth ?? "---"),
              Icons.cake),
          const Divider(height: 24, thickness: 1, color: Color(0xFFF3F4F6)),
          _infoRow("Gender", data.gender ?? "---", Icons.person_outline),
        ],
      ),
    );
  }

  Widget _buildAddressCard(InvestorProfileDataEntity data) {
    final address = data.userAddressDetails?.isNotEmpty == true
        ? data.userAddressDetails!.first
        : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.home_work_outlined,
                  size: 20, color: AppColors.primaryColor),
              SizedBox(width: 12),
              Text(
                'Primary Address',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Spacer(),
            ],
          ),
          const SizedBox(height: 12),
          _infoRow("Address Line", address?.line1 ?? "---", null),
          _infoRow("Locality", address?.line2 ?? "---", null),
          _infoRow("City", address?.city ?? "---", null),
          _infoRow("State", address?.state ?? "---", null),
          _infoRow("Pincode", address?.pincode ?? "---", null),
        ],
      ),
    );
  }

  Widget _buildBankCard(InvestorProfileDataEntity data) {
    final bank = data.userBankDetails;

    if (bank == null || bank.isEmpty) return _buildAddBankButton();

    return BlocListener<ChangePrimaryBankCubit, ChangePrimaryBankState>(
      listener: (context, state) {
        if (state is ChangePrimaryBankFailureState) {
          CustomSnackBar.show(
            context,
            backgroundColor: AppColors.errorRed,
            message: state.errorMessage.toString(),
          );
        } else if (state is ChangePrimaryBankSuccessState) {
          CustomSnackBar.show(
            context,
            backgroundColor: AppColors.primaryColor,
            message: "Primary Bank Updated Successfully",
          );
          context.read<InvesterProfileDataCubit>().fetchInvestorProfileData(
                params:
                    InvestorProfileDataParams.withUserIdFilter(widget.userId),
              );
        }
      },
      child: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bank.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.account_balance,
                                size: 25,
                                color: AppColors.backgroundGrey,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bank[index].bankName?.toUpperCase() ?? "---",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  'Savings Account',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            bank[index].isPrimary == true
                                ? const CustomSmallTextButton(text: "Primary")
                                : CustomSmallTextButton(
                                    onTap: () {
                                      context
                                          .read<ChangePrimaryBankCubit>()
                                          .changePrimaryBank(
                                            userId: widget.userId,
                                            bankId: bank[index].id ?? 0,
                                          );
                                    },
                                    text: "Set Primary",
                                    backgroundColor: AppColors.pureWhite,
                                    textColor: AppColors.primaryGreen,
                                  ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _infoRow(
                            "Account Number",
                            bank[index].accountNumber ?? "---",
                            Icons.credit_card),
                        const Divider(
                            height: 24, thickness: 1, color: Color(0xFFF3F4F6)),
                        _infoRow(
                            "Account Holder Name",
                            bank[index].accountHolderName ?? "---",
                            Icons.person),
                        const Divider(
                            height: 24, thickness: 1, color: Color(0xFFF3F4F6)),
                        _infoRow("IFSC Code", bank[index].ifscCode ?? "---",
                            Icons.confirmation_number),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          _buildAddBankButton(),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, IconData? icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null)
          Icon(icon, color: AppColors.primaryColor, size: 20)
        else
          const SizedBox(width: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddBankButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton.icon(
          onPressed: () {
            context.pushRoute(AddNewBankRoute(userId: widget.userId));
          },
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Bank Account'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle:
                const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _tabs(BuildContext context, InvestorProfileDataEntity data) {
    return CustomTabView(
      tabContents: [
        PortfolioSummaryTab(userId: data.userId ?? 0),
        AccountSummaryTab(userId: widget.userId),
        TransactionTab(userId: widget.userId),
        HoldingsTab(userId: widget.userId),
        UserGoalsTab(userId: widget.userId),
        const Center(child: Text("Tab 6")),
        const Center(child: Text("Tab 7")),
        const Center(child: Text("Tab 8")),
      ],
      tabTitles: const [
        "PortFoliio Summary",
        "Account  Summary",
        "Transactions",
        "Holdings",
        "Goals",
        "Bank Mandates",
        "Capital Gains",
        "Scheme wise",
      ],
    );
  }
}
