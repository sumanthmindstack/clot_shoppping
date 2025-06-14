// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../config/routes/app_router.dart' as _i691;
import '../core/api/api_client.dart' as _i424;
import '../core/api/injection_module.dart' as _i821;
import '../core/data_source/token_local_data_source.dart' as _i512;
import '../core/data_source/user_local_data_source.dart' as _i735;
import '../core/repository/token_repository.dart' as _i1064;
import '../core/repository/token_repository_impl.dart' as _i888;
import '../core/utils/loading_cubit.dart' as _i376;
import '../core/utils/token_service.dart' as _i175;
import '../features/auth/data/data_source/auth_api_services.dart' as _i152;
import '../features/auth/data/repository/auth_repo_impl.dart' as _i100;
import '../features/auth/domain/repository/auth_repo.dart' as _i358;
import '../features/auth/domain/usecase/auth_user_usecase.dart' as _i437;
import '../features/auth/domain/usecase/contact_details_usecase.dart' as _i1042;
import '../features/auth/domain/usecase/euin_usecase.dart' as _i884;
import '../features/auth/domain/usecase/find_one_usecase.dart' as _i1059;
import '../features/auth/domain/usecase/generate_otp_usecase.dart' as _i117;
import '../features/auth/domain/usecase/get_euin_details_usecase.dart' as _i646;
import '../features/auth/domain/usecase/mfd_patch_address_details_usecase.dart'
    as _i559;
import '../features/auth/domain/usecase/mfd_patch_usecase.dart' as _i212;
import '../features/auth/domain/usecase/mfd_usecase.dart' as _i962;
import '../features/auth/domain/usecase/register_user_usecase.dart' as _i813;
import '../features/auth/domain/usecase/ria_bank_usecase.dart' as _i348;
import '../features/auth/domain/usecase/ria_patch_usecase.dart' as _i431;
import '../features/auth/domain/usecase/ria_usecase.dart' as _i1046;
import '../features/auth/domain/usecase/verify_otp_usecase.dart' as _i70;
import '../features/auth/presentation/bloc/address_corres_detail_selected/address_corres_detail_selected_cubit.dart'
    as _i723;
import '../features/auth/presentation/bloc/auth_user/auth_user_cubit.dart'
    as _i524;
import '../features/auth/presentation/bloc/contact_details/contact_details_cubit.dart'
    as _i927;
import '../features/auth/presentation/bloc/euin/euin_cubit.dart' as _i257;
import '../features/auth/presentation/bloc/find_one/find_one_cubit.dart'
    as _i478;
import '../features/auth/presentation/bloc/generate_otp/generate_otp_cubit.dart'
    as _i445;
import '../features/auth/presentation/bloc/get_euin_details/get_euin_details_cubit.dart'
    as _i996;
import '../features/auth/presentation/bloc/mfd/mfd_cubit.dart' as _i634;
import '../features/auth/presentation/bloc/mfd_flow_check/mfd_flow_check_cubit.dart'
    as _i574;
import '../features/auth/presentation/bloc/mfd_patch/mfd_patch_cubit.dart'
    as _i410;
import '../features/auth/presentation/bloc/mfd_patch_address_details/mfd_patch_address_details_cubit.dart'
    as _i937;
import '../features/auth/presentation/bloc/pass_id_pagetopage/pass_id_pagetopage_cubit.dart'
    as _i500;
import '../features/auth/presentation/bloc/register_user/register_user_cubit.dart'
    as _i776;
import '../features/auth/presentation/bloc/registration_flow/registration_flow_cubit.dart'
    as _i737;
import '../features/auth/presentation/bloc/ria/ria_cubit.dart' as _i104;
import '../features/auth/presentation/bloc/ria_bank/ria_bank_cubit.dart'
    as _i124;
import '../features/auth/presentation/bloc/ria_contact_details/ria_contact_details_cubit.dart'
    as _i160;
import '../features/auth/presentation/bloc/ria_flow_check/ria_flow_check_cubit.dart'
    as _i379;
import '../features/auth/presentation/bloc/ria_patch/ria_patch_cubit.dart'
    as _i462;
import '../features/auth/presentation/bloc/verify_otp/verify_otp_cubit.dart'
    as _i692;
import '../features/dashboard/data/data_source/home_dash_api_service.dart'
    as _i576;
import '../features/dashboard/data/repository/home_dash_repo_impl.dart'
    as _i429;
import '../features/dashboard/domain/repository/home_dash_repo.dart' as _i157;
import '../features/dashboard/domain/usecase/dash_aum_report_graph_usecase.dart'
    as _i261;
import '../features/dashboard/domain/usecase/dash_monthwise_invester_details_graph_usecase.dart'
    as _i675;
import '../features/dashboard/domain/usecase/dash_monthwise_sip_details_graph_usecase.dart'
    as _i689;
import '../features/dashboard/domain/usecase/dash_monthwise_trans_details_graph_usecase.dart'
    as _i67;
import '../features/dashboard/domain/usecase/dash_monthwise_user_details_graph_usecase.dart'
    as _i780;
import '../features/dashboard/domain/usecase/dashboard_data_count_usecase.dart'
    as _i559;
import '../features/dashboard/domain/usecase/trans_typewise_returns_usecase.dart'
    as _i871;
import '../features/dashboard/presentation/bloc/dash_aum_report_graph/dash_aum_report_graph_cubit.dart'
    as _i511;
import '../features/dashboard/presentation/bloc/dash_monthwise_invester_details_graph/dash_monthwise_invester_details_graph_cubit.dart'
    as _i641;
import '../features/dashboard/presentation/bloc/dash_monthwise_sip_details_graph/dash_monthwise_sip_details_graph_cubit.dart'
    as _i678;
import '../features/dashboard/presentation/bloc/dash_monthwise_trans_details_graph/dash_monthwise_trans_details_graph_cubit.dart'
    as _i704;
import '../features/dashboard/presentation/bloc/dash_monthwise_user_details_graph/dash_monthwise_user_details_graph_cubit.dart'
    as _i178;
import '../features/dashboard/presentation/bloc/dashboard_data_count/dashboard_data_count_cubit.dart'
    as _i434;
import '../features/dashboard/presentation/bloc/selected_type/selected_type_cubit.dart'
    as _i211;
import '../features/dashboard/presentation/bloc/trans_typewise_returns/trans_typewise_returns_cubit.dart'
    as _i977;
import '../features/investers/data/data_source/invester_api_service.dart'
    as _i348;
import '../features/investers/data/repository/invester_repo_impl.dart' as _i184;
import '../features/investers/domain/repository/invester_repo.dart' as _i823;
import '../features/investers/domain/usecase/account_summary_data_usecase.dart'
    as _i510;
import '../features/investers/domain/usecase/add_new_bank_usecase.dart' as _i7;
import '../features/investers/domain/usecase/change_primary_bank_usecase.dart'
    as _i1004;
import '../features/investers/domain/usecase/check_kyc_usecase.dart' as _i751;
import '../features/investers/domain/usecase/edit_invester_details_usecase.dart'
    as _i792;
import '../features/investers/domain/usecase/get_all_bank_usecase.dart'
    as _i1054;
import '../features/investers/domain/usecase/get_bank_mandates_usecase.dart'
    as _i522;
import '../features/investers/domain/usecase/get_capital_gains_usecase.dart'
    as _i904;
import '../features/investers/domain/usecase/get_holding_details_usecase.dart'
    as _i493;
import '../features/investers/domain/usecase/get_invester_list_usecase.dart'
    as _i220;
import '../features/investers/domain/usecase/get_kyc_details_usecase.dart'
    as _i1037;
import '../features/investers/domain/usecase/get_kyc_user_list_usecase.dart'
    as _i420;
import '../features/investers/domain/usecase/get_lumpsum_data_usecase.dart'
    as _i712;
import '../features/investers/domain/usecase/get_redeemption_data_usecase.dart'
    as _i115;
import '../features/investers/domain/usecase/get_scheme_wise_usecase.dart'
    as _i567;
import '../features/investers/domain/usecase/get_sip_data_usecase.dart'
    as _i973;
import '../features/investers/domain/usecase/get_stp_data_usecase.dart'
    as _i613;
import '../features/investers/domain/usecase/get_switch_data_usecase.dart'
    as _i877;
import '../features/investers/domain/usecase/get_swp_data_usecase.dart'
    as _i650;
import '../features/investers/domain/usecase/get_transaction_details_usecase.dart'
    as _i216;
import '../features/investers/domain/usecase/get_user_goals_details_usecase.dart'
    as _i263;
import '../features/investers/domain/usecase/investor_profile_usecase.dart'
    as _i821;
import '../features/investers/domain/usecase/portfolio_analysis_graph_data_usecase.dart'
    as _i936;
import '../features/investers/domain/usecase/portfolio_analysis_usecase.dart'
    as _i573;
import '../features/investers/domain/usecase/post_bank_mandates_usecase.dart'
    as _i845;
import '../features/investers/presentation/bloc/account_summary_data/account_summary_data_cubit.dart'
    as _i687;
import '../features/investers/presentation/bloc/add_new_bank/add_new_bank_cubit.dart'
    as _i488;
import '../features/investers/presentation/bloc/change_primary_bank/change_primary_bank_cubit.dart'
    as _i329;
import '../features/investers/presentation/bloc/check_kyc/check_kyc_cubit.dart'
    as _i1035;
import '../features/investers/presentation/bloc/edit_invester_details/edit_invester_details_cubit.dart'
    as _i151;
import '../features/investers/presentation/bloc/get_all_bank/get_all_bank_cubit.dart'
    as _i277;
import '../features/investers/presentation/bloc/get_bank_mandates/get_bank_mandates_cubit.dart'
    as _i469;
import '../features/investers/presentation/bloc/get_capital_gains/get_capital_gains_cubit.dart'
    as _i984;
import '../features/investers/presentation/bloc/get_holding_details/get_holding_details_cubit.dart'
    as _i655;
import '../features/investers/presentation/bloc/get_invester_list/get_invester_list_cubit.dart'
    as _i612;
import '../features/investers/presentation/bloc/get_kyc_details/get_kyc_details_cubit.dart'
    as _i790;
import '../features/investers/presentation/bloc/get_kyc_user_list/get_kyc_user_list_cubit.dart'
    as _i668;
import '../features/investers/presentation/bloc/get_lumpsum_data/get_lumpsum_data_cubit.dart'
    as _i967;
import '../features/investers/presentation/bloc/get_reedemption_data.dart/get_reedemption_data_cubit.dart'
    as _i1041;
import '../features/investers/presentation/bloc/get_scheme_wise/get_scheme_wise_cubit.dart'
    as _i466;
import '../features/investers/presentation/bloc/get_sip_data/get_sip_data_cubit.dart'
    as _i279;
import '../features/investers/presentation/bloc/get_stp_data.dart/get_stp_data_cubit.dart'
    as _i363;
import '../features/investers/presentation/bloc/get_switch_data/get_switch_data_cubit.dart'
    as _i994;
import '../features/investers/presentation/bloc/get_swp_data.dart/get_swp_data_cubit.dart'
    as _i431;
import '../features/investers/presentation/bloc/get_transaction_details.dart/get_transaction_details_cubit.dart'
    as _i822;
import '../features/investers/presentation/bloc/input_selection/input_selection_cubit.dart'
    as _i995;
import '../features/investers/presentation/bloc/investor_profile_data/investor_profile_data_cubit.dart'
    as _i199;
import '../features/investers/presentation/bloc/portfolio_analysis/portfolio_analysis_cubit.dart'
    as _i42;
import '../features/investers/presentation/bloc/portfolio_analysis_graph_data/portfolio_analysis_graph_data_cubit.dart'
    as _i513;
import '../features/investers/presentation/bloc/post_bank_mandates/post_bank_mandates_cubit.dart'
    as _i1012;
import '../features/investers/presentation/bloc/selected_user/selected_user_cubit.dart'
    as _i577;
import '../features/investers/presentation/bloc/show_kyc_message/show_kyc_message_cubit.dart'
    as _i193;
import '../features/investers/presentation/bloc/user_goals/get_user_goals_details_cubit.dart'
    as _i1042;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectionModule = _$InjectionModule();
  gh.factory<_i723.AddressCorresDetailSelectedCubit>(
      () => _i723.AddressCorresDetailSelectedCubit());
  gh.factory<_i574.MfdFlowCheckCubit>(() => _i574.MfdFlowCheckCubit());
  gh.factory<_i500.PassIdPagetopageCubit>(() => _i500.PassIdPagetopageCubit());
  gh.factory<_i737.RegistrationFlowCubit>(() => _i737.RegistrationFlowCubit());
  gh.factory<_i379.RiaFlowCheckCubit>(() => _i379.RiaFlowCheckCubit());
  gh.factory<_i211.SelectedTypeCubit>(() => _i211.SelectedTypeCubit());
  gh.factory<_i995.InputSelectionCubit>(() => _i995.InputSelectionCubit());
  gh.factory<_i577.SelectedUserCubit>(() => _i577.SelectedUserCubit());
  gh.factory<_i193.KycMessageCubit>(() => _i193.KycMessageCubit());
  gh.lazySingleton<_i691.AppRouter>(() => _i691.AppRouter());
  gh.lazySingleton<_i895.Connectivity>(() => injectionModule.connectivity());
  gh.lazySingleton<_i376.LoadingCubit>(() => _i376.LoadingCubit());
  gh.lazySingleton<_i735.UserLocalDataSource>(
      () => _i735.UserLocalDataSourceImpl());
  gh.factory<String>(
    () => injectionModule.baseUrl,
    instanceName: 'baseUrl',
  );
  gh.lazySingleton<_i512.TokenLocalDataSource>(
      () => _i512.TokenLocalDataSourceImpl());
  gh.lazySingleton<_i361.Dio>(
      () => injectionModule.dio(gh<String>(instanceName: 'baseUrl')));
  gh.lazySingleton<_i1064.TokenRepository>(
      () => _i888.TokenRepositoryImpl(gh<_i512.TokenLocalDataSource>()));
  gh.lazySingleton<_i175.TokenService>(() => _i175.TokenService(
        gh<_i361.Dio>(),
        gh<_i1064.TokenRepository>(),
      ));
  gh.lazySingleton<_i424.ApiClient>(() => _i424.ApiClient(
        gh<_i361.Dio>(),
        gh<_i175.TokenService>(),
      ));
  gh.lazySingleton<_i576.HomeDashApiService>(
      () => _i576.HomeDashApiServiceImpl(gh<_i424.ApiClient>()));
  gh.lazySingleton<_i348.InvesterApiService>(
      () => _i348.InvesterApiServiceImpl(gh<_i424.ApiClient>()));
  gh.lazySingleton<_i823.InvesterRepo>(
      () => _i184.InvesterRepoImpl(gh<_i348.InvesterApiService>()));
  gh.lazySingleton<_i152.AuthApiServices>(
      () => _i152.AuthApiServiceIMpl(gh<_i424.ApiClient>()));
  gh.lazySingleton<_i157.HomeDashRepo>(
      () => _i429.HomeDashRepoImpl(gh<_i576.HomeDashApiService>()));
  gh.factory<_i559.DashboardDataCountUsecase>(
      () => _i559.DashboardDataCountUsecase(gh<_i157.HomeDashRepo>()));
  gh.factory<_i261.DashAumReportGraphUsecase>(
      () => _i261.DashAumReportGraphUsecase(gh<_i157.HomeDashRepo>()));
  gh.factory<_i675.DashMonthwiseInvesterDetailsGraphUsecase>(() =>
      _i675.DashMonthwiseInvesterDetailsGraphUsecase(gh<_i157.HomeDashRepo>()));
  gh.factory<_i689.DashMonthwiseSipDetailsGraphUsecase>(() =>
      _i689.DashMonthwiseSipDetailsGraphUsecase(gh<_i157.HomeDashRepo>()));
  gh.factory<_i67.DashMonthwiseTransDetailsGraphUsecase>(() =>
      _i67.DashMonthwiseTransDetailsGraphUsecase(gh<_i157.HomeDashRepo>()));
  gh.factory<_i780.DashMonthwiseUserDetailsGraphUsecase>(() =>
      _i780.DashMonthwiseUserDetailsGraphUsecase(gh<_i157.HomeDashRepo>()));
  gh.factory<_i871.TransTypewiseReturnsUsecase>(
      () => _i871.TransTypewiseReturnsUsecase(gh<_i157.HomeDashRepo>()));
  gh.lazySingleton<_i358.AuthRepo>(() => _i100.AuthRepoImpl(
        gh<_i152.AuthApiServices>(),
        gh<_i735.UserLocalDataSource>(),
        gh<_i512.TokenLocalDataSource>(),
      ));
  gh.factory<_i437.AuthUserUsecase>(
      () => _i437.AuthUserUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i1042.ContactDetailsUsecase>(
      () => _i1042.ContactDetailsUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i884.EuinUsecase>(() => _i884.EuinUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i1059.FindOneUsecase>(
      () => _i1059.FindOneUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i117.GenerateOtpUsecase>(
      () => _i117.GenerateOtpUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i646.GetEUINDetailsUsecase>(
      () => _i646.GetEUINDetailsUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i559.MfdPatchAddressDetailsUsecase>(
      () => _i559.MfdPatchAddressDetailsUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i212.MfdPatchUsecase>(
      () => _i212.MfdPatchUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i962.MfdUsecase>(() => _i962.MfdUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i813.RegisterUserUsecase>(
      () => _i813.RegisterUserUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i348.RiaBankUsecase>(
      () => _i348.RiaBankUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i431.RiaPatchUsecase>(
      () => _i431.RiaPatchUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i1046.RiaUsecase>(() => _i1046.RiaUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i70.VerifyOtpUsecase>(
      () => _i70.VerifyOtpUsecase(gh<_i358.AuthRepo>()));
  gh.factory<_i445.GenerateOtpCubit>(
      () => _i445.GenerateOtpCubit(gh<_i117.GenerateOtpUsecase>()));
  gh.factory<_i445.ReGenerateOtpCubit>(
      () => _i445.ReGenerateOtpCubit(gh<_i117.GenerateOtpUsecase>()));
  gh.factory<_i434.DashboardDataCountCubit>(() =>
      _i434.DashboardDataCountCubit(gh<_i559.DashboardDataCountUsecase>()));
  gh.factory<_i511.DashAumReportGraphCubit>(() =>
      _i511.DashAumReportGraphCubit(gh<_i261.DashAumReportGraphUsecase>()));
  gh.factory<_i178.DashMonthwiseUserDetailsGraphCubit>(() =>
      _i178.DashMonthwiseUserDetailsGraphCubit(
          gh<_i780.DashMonthwiseUserDetailsGraphUsecase>()));
  gh.factory<_i478.FindOneCubit>(
      () => _i478.FindOneCubit(gh<_i1059.FindOneUsecase>()));
  gh.factory<_i776.RegisterUserCubit>(
      () => _i776.RegisterUserCubit(gh<_i813.RegisterUserUsecase>()));
  gh.factory<_i996.GetEuinDetailsCubit>(
      () => _i996.GetEuinDetailsCubit(gh<_i646.GetEUINDetailsUsecase>()));
  gh.factory<_i510.AccountSummaryDataUsecase>(
      () => _i510.AccountSummaryDataUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i7.AddNewBankUsecase>(
      () => _i7.AddNewBankUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i1004.ChangePrimaryBankUsecase>(
      () => _i1004.ChangePrimaryBankUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i792.EditInvesterDetailsUsecase>(
      () => _i792.EditInvesterDetailsUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i493.GetHoldingsDetailsUsecase>(
      () => _i493.GetHoldingsDetailsUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i220.GetInvesterListUsecase>(
      () => _i220.GetInvesterListUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i1037.GetKycDetailsUsecase>(
      () => _i1037.GetKycDetailsUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i420.GetKycUserListUseCase>(
      () => _i420.GetKycUserListUseCase(gh<_i823.InvesterRepo>()));
  gh.factory<_i712.GetLumpsumDataUsecase>(
      () => _i712.GetLumpsumDataUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i115.GetRedeemDataUsecase>(
      () => _i115.GetRedeemDataUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i973.GetSipDataUsecase>(
      () => _i973.GetSipDataUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i613.GetStpDataUsecase>(
      () => _i613.GetStpDataUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i877.GetSwitchDataUsecase>(
      () => _i877.GetSwitchDataUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i650.GetSwpDataUsecase>(
      () => _i650.GetSwpDataUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i216.GetTransactionDetailsUsecase>(
      () => _i216.GetTransactionDetailsUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i821.InvesterProfileDataUsecase>(
      () => _i821.InvesterProfileDataUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i936.PortfolioAnalysisGraphDataUsecase>(
      () => _i936.PortfolioAnalysisGraphDataUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i573.PortfolioAnalysisUsecase>(
      () => _i573.PortfolioAnalysisUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i263.GetUserGoalsDetailsUsecase>(
      () => _i263.GetUserGoalsDetailsUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i522.GetBankMandatesUsecase>(
      () => _i522.GetBankMandatesUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i1054.GetAllBankUsecase>(
      () => _i1054.GetAllBankUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i845.PostBankMandatesUsecase>(
      () => _i845.PostBankMandatesUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i904.GetCapitalGainsUsecase>(
      () => _i904.GetCapitalGainsUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i567.GetSchemeWiseUsecase>(
      () => _i567.GetSchemeWiseUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i751.CheckKycUsecase>(
      () => _i751.CheckKycUsecase(gh<_i823.InvesterRepo>()));
  gh.factory<_i199.InvesterProfileDataCubit>(() =>
      _i199.InvesterProfileDataCubit(gh<_i821.InvesterProfileDataUsecase>()));
  gh.factory<_i692.VerifyOtpCubit>(
      () => _i692.VerifyOtpCubit(gh<_i70.VerifyOtpUsecase>()));
  gh.factory<_i104.RiaCubit>(() => _i104.RiaCubit(gh<_i1046.RiaUsecase>()));
  gh.factory<_i1012.PostBankMandatesCubit>(
      () => _i1012.PostBankMandatesCubit(gh<_i845.PostBankMandatesUsecase>()));
  gh.factory<_i927.ContactDetailsCubit>(
      () => _i927.ContactDetailsCubit(gh<_i1042.ContactDetailsUsecase>()));
  gh.factory<_i160.RiaContactDetailsCubit>(
      () => _i160.RiaContactDetailsCubit(gh<_i1042.ContactDetailsUsecase>()));
  gh.factory<_i151.EditInvesterDetailsCubit>(() =>
      _i151.EditInvesterDetailsCubit(gh<_i792.EditInvesterDetailsUsecase>()));
  gh.factory<_i363.GetStpDataCubit>(
      () => _i363.GetStpDataCubit(gh<_i613.GetStpDataUsecase>()));
  gh.factory<_i329.ChangePrimaryBankCubit>(() =>
      _i329.ChangePrimaryBankCubit(gh<_i1004.ChangePrimaryBankUsecase>()));
  gh.factory<_i704.DashMonthwiseTransDetailsGraphCubit>(() =>
      _i704.DashMonthwiseTransDetailsGraphCubit(
          gh<_i67.DashMonthwiseTransDetailsGraphUsecase>()));
  gh.factory<_i994.GetSwitchDataCubit>(
      () => _i994.GetSwitchDataCubit(gh<_i877.GetSwitchDataUsecase>()));
  gh.factory<_i257.EuinCubit>(() => _i257.EuinCubit(gh<_i884.EuinUsecase>()));
  gh.factory<_i634.MfdCubit>(() => _i634.MfdCubit(gh<_i962.MfdUsecase>()));
  gh.factory<_i937.MfdPatchAddressDetailsCubit>(() =>
      _i937.MfdPatchAddressDetailsCubit(
          gh<_i559.MfdPatchAddressDetailsUsecase>()));
  gh.factory<_i488.AddNewBankCubit>(
      () => _i488.AddNewBankCubit(gh<_i7.AddNewBankUsecase>()));
  gh.factory<_i279.GetSipDataCubit>(
      () => _i279.GetSipDataCubit(gh<_i973.GetSipDataUsecase>()));
  gh.factory<_i462.RiaPatchCubit>(
      () => _i462.RiaPatchCubit(gh<_i431.RiaPatchUsecase>()));
  gh.factory<_i277.GetAllBankCubit>(
      () => _i277.GetAllBankCubit(gh<_i1054.GetAllBankUsecase>()));
  gh.factory<_i668.GetKycUserListCubit>(
      () => _i668.GetKycUserListCubit(gh<_i420.GetKycUserListUseCase>()));
  gh.factory<_i822.GetTransactionDetailsCubit>(() =>
      _i822.GetTransactionDetailsCubit(
          gh<_i216.GetTransactionDetailsUsecase>()));
  gh.factory<_i641.DashMonthwiseInvesterDetailsGraphCubit>(() =>
      _i641.DashMonthwiseInvesterDetailsGraphCubit(
          gh<_i675.DashMonthwiseInvesterDetailsGraphUsecase>()));
  gh.factory<_i410.MfdPatchCubit>(
      () => _i410.MfdPatchCubit(gh<_i212.MfdPatchUsecase>()));
  gh.factory<_i655.GetHoldingDetailsCubit>(() =>
      _i655.GetHoldingDetailsCubit(gh<_i493.GetHoldingsDetailsUsecase>()));
  gh.factory<_i42.PortfolioAnalysisCubit>(
      () => _i42.PortfolioAnalysisCubit(gh<_i573.PortfolioAnalysisUsecase>()));
  gh.factory<_i687.AccountSummaryDataCubit>(() =>
      _i687.AccountSummaryDataCubit(gh<_i510.AccountSummaryDataUsecase>()));
  gh.factory<_i513.PortfolioAnalysisGraphDataCubit>(() =>
      _i513.PortfolioAnalysisGraphDataCubit(
          gh<_i936.PortfolioAnalysisGraphDataUsecase>()));
  gh.factory<_i524.AuthUserCubit>(
      () => _i524.AuthUserCubit(gh<_i437.AuthUserUsecase>()));
  gh.factory<_i790.GetKycDetailsCubit>(
      () => _i790.GetKycDetailsCubit(gh<_i1037.GetKycDetailsUsecase>()));
  gh.factory<_i678.DashMonthwiseSipDetailsGraphCubit>(() =>
      _i678.DashMonthwiseSipDetailsGraphCubit(
          gh<_i689.DashMonthwiseSipDetailsGraphUsecase>()));
  gh.factory<_i466.GetSchemeWiseCubit>(
      () => _i466.GetSchemeWiseCubit(gh<_i567.GetSchemeWiseUsecase>()));
  gh.factory<_i977.TransTypewiseReturnsCubit>(() =>
      _i977.TransTypewiseReturnsCubit(gh<_i871.TransTypewiseReturnsUsecase>()));
  gh.factory<_i124.RiaBankCubit>(
      () => _i124.RiaBankCubit(gh<_i348.RiaBankUsecase>()));
  gh.factory<_i469.GetBankMandatesCubit>(
      () => _i469.GetBankMandatesCubit(gh<_i522.GetBankMandatesUsecase>()));
  gh.factory<_i984.GetCapitalGainsCubit>(
      () => _i984.GetCapitalGainsCubit(gh<_i904.GetCapitalGainsUsecase>()));
  gh.factory<_i1041.GetRedeemDataCubit>(
      () => _i1041.GetRedeemDataCubit(gh<_i115.GetRedeemDataUsecase>()));
  gh.factory<_i1042.GetUserGoalsDetailsCubit>(() =>
      _i1042.GetUserGoalsDetailsCubit(gh<_i263.GetUserGoalsDetailsUsecase>()));
  gh.factory<_i612.GetInvesterListCubit>(
      () => _i612.GetInvesterListCubit(gh<_i220.GetInvesterListUsecase>()));
  gh.factory<_i431.GetSwpDataCubit>(
      () => _i431.GetSwpDataCubit(gh<_i650.GetSwpDataUsecase>()));
  gh.factory<_i967.GetLumpsumDataCubit>(
      () => _i967.GetLumpsumDataCubit(gh<_i712.GetLumpsumDataUsecase>()));
  gh.factory<_i1035.CheckKycCubit>(
      () => _i1035.CheckKycCubit(gh<_i751.CheckKycUsecase>()));
  return getIt;
}

class _$InjectionModule extends _i821.InjectionModule {}
