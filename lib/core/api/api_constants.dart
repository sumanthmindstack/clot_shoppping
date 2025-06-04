class ApiConstants {
  ApiConstants._();
  static const String baseUrl = "https://torusapi.mindstack.in/api/";
  static const String superAdminbaseUrl =
      "https://torussuperadminapi.mindstack.in/api";

  //Auth
  static const String generateOTPEndPoint = "/auth/generate_otp";
  static const String verifyOTPEndPoint = "/auth/verify_otp";
  static const String authUserEndPoint = "/auth/user";

  //super Admin mfd registration apis
  static const String registerUserEndPoint = "$superAdminbaseUrl/users";
  static const String mfdEndPoint = "$superAdminbaseUrl/mfd";
  static const String findOneEndPoint = "$superAdminbaseUrl/mfd/findOne";
  static const String getEUINDataEndPoint = "$superAdminbaseUrl/euin";
  static const String euinEndPoint = "$superAdminbaseUrl/euin";
  //super Admin ria registration apis
  static const String registerRiaUserEndPoint = "$superAdminbaseUrl/ria";
  static const String riaBankUserEndPoint = "$superAdminbaseUrl/ria-bank";

  //dashboard home apis
  static const String dashboardDataCount = "/admin/reports/get_data_count";
  static const String dashAumReportEndpoint = "/admin/reports/aum_report_graph";
  static const String dashMonthwiseUserDetailsGraph =
      "/admin/users/total_users";
  static const String dashMonthwiseInvesterDetailsGraph =
      "/admin/onboarding/total_investors";
  static const String dashMonthwiseTransDetailsGraph =
      "/transactions/transaction_by_year";
  static const String transTypewiseReturns =
      "/transactions/transaction_type_wise_returns";
  static const String dashMonthWiseSipDetailsEndPoint =
      "/transactions/total_transaction_per_year";

  //investor page apis
  static const String getInvestersList = "/admin/onboarding/search";
  static const String getKycUserList = "/admin/users";
  static const String checkKyCEndpoint = "/onboarding/check_kyc";
  static const String getKycDetailsEndpoint = "/onboarding/get_kyc_details";
  static const String getInvesterProfileDataEndpoint = "/admin/onboarding";
  static const String editInvesterEndpoint = "/onboarding/user_details";
  static const String changePrimaryBankEndpoint = "/bank/change_primary_bank";
  static const String addNewBankEndpoint = "/bank/add_additional_bank";
  static const String portFolioSummaryEndpoint =
      "/portfolio/portfolio_analysis";
  static const String portFolioGraphDataEndpoint = "/portfolio/returns_graph";
  static const String accountSummaryDataEndpoint =
      "/transactions/investment_account_wise_returns";
  static const String getLumpsumDataEndpoint = "/order-status/lumpsum";
}
