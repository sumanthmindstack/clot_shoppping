import 'package:intl/intl.dart';

import '../constants/meta_strings.dart';

// import '../constants/meta_strings.dart';

class Validators {
  Validators._();

  // Function: validateEmail
  // Description: Validates an email address
  // Parameters:
  //  - email: The email address to validate
  // Returns:
  //  - true if the email is valid, false otherwise
  static bool _validateEmail(String email) {
    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return emailExp.hasMatch(email);
  }

// ARN Code
  static bool _validateArn(String arn) {
    RegExp arnExp = RegExp(r"^\d{12,23}$");
    return arnExp.hasMatch(arn);
  }

// OTP Validator Code
  static bool _validateOtp(String otp) {
    // Accepts a 6-digit numeric OTP
    RegExp otpExp = RegExp(r"^\d{4}$");
    return otpExp.hasMatch(otp);
  }

  // Function: validateDrivingLicense
  // Description: Validates a driving license number
  // Parameters:
  //  - drivingLicense: The driving license number to validate
  // Returns:
  //  - true if the driving license number is valid, false otherwise
  static bool _validateDrivingLicense(String drivingLicense) {
    RegExp drivingLicenseExp = RegExp(r'^[A-Z]{2}[0-9]{2}[ ][0-9]{11}$');
    return drivingLicenseExp.hasMatch(drivingLicense);
  }

  // Function: validatePassport
  // Description: Validates a passport number
  // Parameters:
  //  - passport: The passport number to validate
  // Returns:
  //  - true if the passport number is valid, false otherwise
  static bool _validatePassport(String passport) {
    RegExp passportExp = RegExp(r'^[A-PR-WYa-pr-wy][1-9]\d\s?\d{4}[1-9]$');
    return passportExp.hasMatch(passport);
  }

  // Function: validateVoterId
  // Description: Validates a voter ID number
  // Parameters:
  //  - voterId: The voter ID number to validate
  // Returns:
  //  - true if the voter ID number is valid, false otherwise
  static bool _validateVoterId(String voterId) {
    RegExp voterIdExp = RegExp(r'^[A-Z]{3}[0-9]{7}$');
    return voterIdExp.hasMatch(voterId);
  }

  //Function: validateMobileNumber
  //Description: Validates a mobile number
  //Parameters:
  // - mobileNumber: The mobile number to validate
  //Returns:
  // - true if the mobile number is valid, false otherwise
  static bool _validateMobileNumber(String mobileNumber) {
    RegExp mobileNumberExp = RegExp(r"^[0-9]{10}$");
    return mobileNumberExp.hasMatch(mobileNumber);
  }

  //Function: validatePanNumber
  //Description: Validates a pan number
  //Parameters:
  // - panNumber: The pan number to validate
  //Returns:
  // - true if the pan number is valid, false otherwise
  static bool _validatePanNumber(String panNumber) {
    //regex for validating pan number without considering the case
    RegExp panNumberExp = RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]$");
    return panNumberExp.hasMatch(panNumber);
  }

  static bool _validateTanNumber(String tanNumber) {
    // Regex for validating TAN number
    RegExp tanNumberExp = RegExp(r"^[A-Z]{4}[0-9]{5}[A-Z]$");
    return tanNumberExp.hasMatch(tanNumber);
  }

  static const List<String> _validAccountTypes = [
    'Savings',
    'Current',
    'Checking',
    'Business',
    'Fixed Deposit',
    // Add more if needed
  ];

  static bool _validateBankAccountType(String type) {
    return _validAccountTypes.contains(type.trim());
  }

  static const int _requiredLength = 4;

  // Validate MPIN format
  static bool _isValidMpin(String mpin) {
    return mpin.trim().length == _requiredLength &&
        RegExp(r'^\d{4}$').hasMatch(mpin.trim());
  }

  static bool _validateBeneficiaryName(String name) {
    return name.trim().isNotEmpty;
  }

  static bool _validateBankAccountName(String name) {
    return name.trim().isNotEmpty;
  }

  static bool _validateMICR(String micr) {
    RegExp micrExp = RegExp(r'^\d{9}$');
    return micrExp.hasMatch(micr);
  }

  static bool _validateRiaCode(String riaCode) {
    // Regex for validating RIA code: starts with INA followed by 6 digits
    RegExp riaCodeExp = RegExp(r"^INA\d{6}$");
    return riaCodeExp.hasMatch(riaCode);
  }

  static bool _validateStdCode(String stdCode) {
    // Regex for validating STD Code (3 to 5 digits)
    RegExp stdCodeExp = RegExp(r"^\d{3,5}$");
    return stdCodeExp.hasMatch(stdCode);
  }

  static bool _validateCountryCode(String code) {
    // Regex: + followed by 1 to 4 digits
    RegExp countryCodeExp = RegExp(r"^\+\d{1,4}$");
    return countryCodeExp.hasMatch(code);
  }

  static bool _validatePrimaryLandline(String landline) {
    // Regex for validating Primary Landline (6 to 8 digits)
    RegExp landlineExp = RegExp(r"^\d{6,8}$");
    return landlineExp.hasMatch(landline);
  }

  static bool _validateCity(String city) {
    // Regex for validating city (letters and spaces, min 2 chars)
    RegExp cityExp = RegExp(r"^[A-Za-z ]{2,}$");
    return cityExp.hasMatch(city);
  }

  static bool _validateArea(String area) {
    // Regex for validating area (only alphabets and spaces, min 2 chars)
    RegExp areaExp = RegExp(r"^[A-Za-z ]{2,}$");
    return areaExp.hasMatch(area);
  }

  static bool _validateEntityName(String name) {
    // Regex for validating entity names (letters, spaces, &, ., and - allowed)
    RegExp entityNameExp = RegExp(r"^[A-Za-z&.\- ]{2,}$");
    return entityNameExp.hasMatch(name);
  }

  static bool _validateName(String name) {
    // Allows letters, spaces, &, ., and -; at least 2 characters
    RegExp nameExp = RegExp(r"^[A-Za-z&.\- ]{2,}$");
    return nameExp.hasMatch(name);
  }

  static bool _validateWebsite(String website) {
    // Basic regex to validate website URLs (without enforcing https)
    RegExp websiteExp =
        RegExp(r"^(https?:\/\/)?(www\.)?[a-zA-Z0-9-]+\.[a-zA-Z]{2,}(\S*)?$");
    return websiteExp.hasMatch(website);
  }

  static bool _validateEuinCode(String euinCode) {
    // Regex for validating EUIN Code: 4 uppercase letters followed by 6 digits and 1 uppercase letter
    RegExp euinCodeExp = RegExp(r"^[A-Z]{2}[0-9]{6}[A-Z]{2}$");
    return euinCodeExp.hasMatch(euinCode);
  }

  //Function: validatePinCode
  //Description: Validates a pin code
  //Parameters:
  // - pinCode: The pin code to validate
  //Returns:
  // - true if the pin code is valid, false otherwise
  static bool _validatePinCode(String pinCode) {
    RegExp pinCodeExp = RegExp(r"^[0-9]{6,8}$");
    return pinCodeExp.hasMatch(pinCode);
  }

  //Function: validateIFSCCode
  //Description: Validates an IFSCCode for Indian bank accounts
  //Parameters:
  // - ifscCode: The IFSCCode to validate
  //Returns:
  // - true if the IFSCCode is valid, false otherwise
  static bool _validateIFSCCode(String ifscCode) {
    RegExp ifscCodeExp =
        RegExp(r'^[a-zA-Z]{4}0[a-zA-Z0-9]{6}$', caseSensitive: false);
    return ifscCodeExp.hasMatch(ifscCode);
  }

  //Function: validateBankAccountNumber
  //Description: Validates a bank account number
  //Parameters:
  // - bankAccountNumber: The bank account number to validate
  //Returns:
  // - true if the bank account number is valid, false otherwise
  static bool _validateBankAccountNumber(String bankAccountNumber) {
    RegExp bankAccountNumberExp = RegExp(r"^[0-9]{9,18}$");
    return bankAccountNumberExp.hasMatch(bankAccountNumber);
  }

  //Function: validateDateOfBirth
  //Description: Validates a date of birth
  //Parameters:
  // - dateOfBirth: The date of birth to validate
  //Returns:
  // - true if the date of birth is valid, false otherwise
  static bool _validateDateOfBirth(String dateOfBirth) {
    RegExp dateOfBirthExp = RegExp(r"^[0-9]{2}[-][0-9]{2}[-][0-9]{4}$");
    return dateOfBirthExp.hasMatch(dateOfBirth);
  }

  //A function that validates email addresses and returns a nullable string
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return ValidatorStrings.emptyEmailIDField;
    }

    if (!_validateEmail(email)) {
      return ValidatorStrings.invalidEmailIDField;
    }
    return null;
  }

  static String? validateOtp(String? otp) {
    if (otp == null || otp.isEmpty) {
      return ValidatorStrings.emptyOtpField;
    }

    if (!_validateOtp(otp)) {
      return ValidatorStrings.invalidOtpField;
    }

    return null;
  }

  static String? validateArn(String? arn) {
    if (arn == null || arn.isEmpty) {
      return ARNValidatorStrings.emptyArnField;
    }

    if (!_validateArn(arn)) {
      return ARNValidatorStrings.invalidArnField;
    }
    return null;
  }

  //A function that validates mobile numbers and returns a nullable string
  static String? validateMobileNumber(String? mobileNumber) {
    if (mobileNumber == null || mobileNumber.isEmpty) {
      return ValidatorStrings.emptyMobileNumberField;
    }

    if (int.parse(mobileNumber) == 0) {
      return ValidatorStrings.invalidMobileNumberField;
    }

    if (!_validateMobileNumber(mobileNumber)) {
      return ValidatorStrings.invalidMobileNumberField;
    }
    return null;
  }

  //A function that validates pan numbers and returns a nullable string
  static String? validatePanNumber(String? panNumber) {
    if (panNumber == null || panNumber.isEmpty) {
      return ValidatorStrings.emptyPanNumberField;
    }

    if (!_validatePanNumber(panNumber)) {
      return ValidatorStrings.invalidPanNumberField;
    }
    return null;
  }

  static String? validateUserSelection(String? selection) {
    if (selection == null || selection.isEmpty) {
      return ValidatorStrings.userSelectionRequired;
    }
    return null;
  }

  //to validate TAN
  static String? validateTanNumber(String? tanNumber) {
    if (tanNumber == null || tanNumber.isEmpty) {
      return ValidatorStrings.emptyTanNumberField;
    }

    if (!_validateTanNumber(tanNumber)) {
      return ValidatorStrings.invalidTanNumberField;
    }
    return null;
  }

  //Validate Account Type
  static String? validateBankAccountType(String? type) {
    if (type == null || type.trim().isEmpty) {
      return ValidatorStrings.emptyAccountTypeField;
    }

    if (!_validateBankAccountType(type)) {
      return ValidatorStrings.invalidAccountTypeField;
    }

    return null;
  }

  static String? validateMpin(String? mpin) {
    if (mpin == null || mpin.trim().isEmpty) {
      return ValidatorStrings.emptyMpinField;
    }

    if (!_isValidMpin(mpin)) {
      return ValidatorStrings.invalidMpinField;
    }

    return null;
  }

  // validate Bank Beneficiary Name
  static String? validateBeneficiaryName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return ValidatorStrings.emptyBeneficiaryNameField;
    }

    if (!_validateBeneficiaryName(name)) {
      return ValidatorStrings.invalidBeneficiaryNameField;
    }

    return null;
  }

  // validate Bank Account Name
  static String? validateBankAccountName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return ValidatorStrings.emptyAccountNameField;
    }

    if (!_validateBankAccountName(name)) {
      return ValidatorStrings.invalidAccountNameField;
    }

    return null;
  }

  static String? validateBankAccountNumber(String? accountNumber) {
    if (accountNumber == null || accountNumber.isEmpty) {
      return ValidatorStrings.emptyBankAccountNumberField;
    }

    if (!_validateBankAccountNumber(accountNumber)) {
      return ValidatorStrings.invalidBankAccountNumberField;
    }
    return null;
  }

  //Validate MICR Number
  static String? validateMICR(String? micr) {
    if (micr == null || micr.isEmpty) {
      return ValidatorStrings
          .emptyMICRField; // Define this string in your ValidatorStrings class
    }

    if (!_validateMICR(micr)) {
      return ValidatorStrings
          .invalidMICRField; // Define this string in your ValidatorStrings class
    }

    return null;
  }

//Validate RIA
  static String? validateRia(String? value) {
    if (value == null || value.isEmpty) {
      return 'INA Code is required';
    }
    final pattern = RegExp(r'^INA\d{7}$');
    if (!pattern.hasMatch(value)) {
      return 'Invalid INA Code (e.g., INA0000123)';
    }
    return null;
  }

  // validate STDCode
  static String? validateStdCode(String? stdCode) {
    if (stdCode == null || stdCode.isEmpty) {
      return ValidatorStrings.emptyStdCodeField;
    }

    if (!_validateStdCode(stdCode)) {
      return ValidatorStrings.invalidStdCodeField;
    }
    return null;
  }

// validate Country Code
  static String? validateCountryCode(String? code) {
    if (code == null || code.isEmpty) {
      return ValidatorStrings.emptyCountryCodeField;
    }

    if (!_validateCountryCode(code)) {
      return ValidatorStrings.invalidCountryCodeField;
    }

    return null;
  }

//validate primary landline
  static String? validatePrimaryLandline(String? landline) {
    if (landline == null || landline.isEmpty) {
      return ValidatorStrings.emptyPrimaryLandlineField;
    }

    if (!_validatePrimaryLandline(landline)) {
      return ValidatorStrings.invalidPrimaryLandlineField;
    }

    return null;
  }

  // validate city
  static String? validateCity(String? city) {
    if (city == null || city.trim().isEmpty) {
      return ValidatorStrings.emptyCityField;
    }

    if (!_validateCity(city.trim())) {
      return ValidatorStrings.invalidCityField;
    }

    return null;
  }

  //validate area
  static String? validateArea(String? area) {
    if (area == null || area.trim().isEmpty) {
      return ValidatorStrings.emptyAreaField;
    }

    if (!_validateArea(area.trim())) {
      return ValidatorStrings.invalidAreaField;
    }

    return null;
  }

  //to validate Entity Name
  static String? validateEntityName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return ValidatorStrings.emptyEntityNameField;
    }

    if (!_validateEntityName(name.trim())) {
      return ValidatorStrings.invalidEntityNameField;
    }
    return null;
  }

//validate Account Name
  static String? validateNameFields(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "Account Holder Name is required"; // Or use ValidatorStrings.emptyEntityNameField;
    }

    if (!_validateName(name.trim())) {
      return "Please enter a valid Account Holder Name"; // Or use ValidatorStrings.invalidEntityNameField;
    }
    return null;
  }

  //validate website
  static String? validateWebsite(String? website) {
    if (website == null || website.trim().isEmpty) {
      return ValidatorStrings.emptyWebsiteField;
    }

    if (!_validateWebsite(website.trim())) {
      return ValidatorStrings.invalidWebsiteField;
    }

    return null;
  }

//validate EUIN
  static String? validateEuinCode(String? euinCode) {
    if (euinCode == null || euinCode.trim().isEmpty) {
      return ValidatorStrings.emptyEuinCodeField;
    }

    if (!_validateEuinCode(euinCode.trim())) {
      return ValidatorStrings.invalidEuinCodeField;
    }

    return null;
  }

  //A function that validates pin codes and returns a nullable string
  static String? validatePinCode(String? pinCode) {
    if (pinCode == null || pinCode.isEmpty) {
      return ValidatorStrings.emptyPinCodeField;
    }

    if (int.parse(pinCode) == 0) {
      return ValidatorStrings.invalidPinCodeField;
    }

    if (!_validatePinCode(pinCode)) {
      return ValidatorStrings.invalidPinCodeField;
    }
    return null;
  }

  //A function that validates IFSCCodes and returns a nullable string
  static String? validateIFSCCode(String? ifscCode) {
    if (ifscCode == null || ifscCode.isEmpty) {
      return ValidatorStrings.emptyIFSCCodeField;
    }

    if (!_validateIFSCCode(ifscCode)) {
      return ValidatorStrings.invalidIFSCCodeField;
    }
    return null;
  }

  //A function that validates bank account numbers and returns a nullable string
  static String? validateBankAccountNumber1(String? bankAccountNumber) {
    if (bankAccountNumber == null || bankAccountNumber.isEmpty) {
      return ValidatorStrings.emptyBankAccountNumberField;
    }

    if (int.parse(bankAccountNumber) == 0) {
      return ValidatorStrings.invalidBankAccountNumberField;
    }

    if (!_validateBankAccountNumber(bankAccountNumber)) {
      return ValidatorStrings.invalidBankAccountNumberField;
    }
    return null;
  }

  //A function that validates date of birth and returns a nullable string
  static String? validateDateOfBirth(String? dateOfBirth) {
    if (dateOfBirth == null || dateOfBirth.isEmpty) {
      return ValidatorStrings.emptyDateOfBirthField;
    }

    if (!_validateDateOfBirth(dateOfBirth)) {
      return ValidatorStrings.invalidDateOfBirthField;
    }
    return null;
  }

  static String? validateUnselectedDropDown(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'please select value';
    }
    return null;
  }

  // A function that takes in Validator String and a value and returns a nullable string
  static String? validateBlankEmptyField(
      String? validatorString, String? value) {
    if (value == null || value.trim().isEmpty) {
      return validatorString;
    }

    return null;
  }

  // A function that takes in Validator String and a value and returns a nullable string
  static String? validateEmptyField(String? validatorString, String? value) {
    if (value == null || value.trim().isEmpty) {
      return validatorString;
    }
    if (value.length < 2) {
      return 'should be more than 1 character';
    }
    return null;
  }

  static String? validateSSNField(String? validatorString, String? value) {
    if (value == null || value.trim().isEmpty) {
      return validatorString;
    }
    if (value.length != 9) {
      return 'should be 9 digits only';
    }
    return null;
  }

  static String? validateNameField(String? validatorString, String? value) {
    if (value == null || value.trim().isEmpty) {
      return validatorString;
    }
    if (value.length < 2) {
      return 'should be more than 1 character';
    }
    if (!RegExp(r'^[a-zA-Z]+(?:\s+[a-zA-Z]+)*$').hasMatch(value)) {
      return 'Please enter a valid name';
    }
    return null;
  }

  static String? validateCountryField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Country is required";
    }
    return null;
  }

  static String? validateStateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "State is required";
    }
    return null;
  }

  static String? validateRiskExpField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Risk Exposure is required";
    }
    return null;
  }

  static String? validateInvestDurationField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Expected investment duration is required";
    }
    return null;
  }

  static String? validatePastPvtInvtField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Past Private Investment is required";
    }
    return null;
  }

  static String? validateAnnualIncomeField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Annual Income is required";
    }
    return null;
  }

  static String? validateJurisdictionField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Jurisdiction is required";
    }
    return null;
  }

  static String? validateNetWorthField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Net worth is required";
    }
    return null;
  }

  static String? validateEntityField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Entity Name is required";
    }
    return null;
  }

  static String? validateLiquidNetWorthField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Liquid Net worth is required";
    }
    return null;
  }

  static String? validateAddressField(String? value) {
    value = value?.trim();
    if (value == null || value.trim().isEmpty) {
      return ValidatorStrings.emptyAddressField;
    }
    if (value.length < 10) {
      return ValidatorStrings.minAddressLength;
    }
    if (value.length > 100) {
      return ValidatorStrings.maxAddressLength;
    }
    return null;
  }

  static String? validateNomineePercentage(String? nomineePercentage) {
    if (nomineePercentage == null || nomineePercentage.isEmpty) {
      return ValidatorStrings.emptyPercentageField;
    }
    if (double.parse(nomineePercentage) > 100 ||
        double.parse(nomineePercentage) <= 0) {
      return ValidatorStrings.invalidPercentageField;
    }
    return null;
  }

  //A function that validates driving license numbers and returns a nullable string
  static String? validateDrivingLicenseNumber(String? drivingLicenseNumber) {
    if (drivingLicenseNumber == null || drivingLicenseNumber.isEmpty) {
      return ValidatorStrings.emptyDrivingLicenseNumberField;
    }

    if (!_validateDrivingLicense(drivingLicenseNumber)) {
      return ValidatorStrings.invalidDrivingLicenseNumberField;
    }
    return null;
  }

  //A function that validates passport numbers and returns a nullable string
  static String? validatePassportNumber(String? passportNumber) {
    if (passportNumber == null || passportNumber.isEmpty) {
      return ValidatorStrings.emptyPassportNumberField;
    }

    if (!_validatePassport(passportNumber)) {
      return ValidatorStrings.invalidPassportNumberField;
    }
    return null;
  }

  //A function that validates voter id numbers and returns a nullable string
  static String? validateVoterIDNumber(String? voterIDNumber) {
    if (voterIDNumber == null || voterIDNumber.isEmpty) {
      return ValidatorStrings.emptyVoterIDNumberField;
    }

    if (!_validateVoterId(voterIDNumber)) {
      return ValidatorStrings.invalidVoterIDNumberField;
    }
    return null;
  }

  static String? dobValidator(String value, {bool shouldBeAdult = false}) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    String str1 = value;
    List<String> str2 = str1.split('-');
    String day = str2.isNotEmpty ? str2[0] : '';
    String month = str2.length > 1 ? str2[1] : '';
    String year = str2.length > 2 ? str2[2] : '';
    if (value.isEmpty) {
      return 'Date is required';
    } else if (value.length != 10) {
      return "Please enter valid date";
    } else if (int.parse(day) > 31) {
      return 'Day is invalid';
    } else if (int.parse(month) > 12) {
      return 'Month is invalid';
    } else if ((int.parse(year) > int.parse(formatted))) {
      return 'Year is invalid';
    } else if ((int.parse(year) < 1920)) {
      return 'Year is invalid';
    } else if (shouldBeAdult && (int.parse(formatted) - int.parse(year) < 18)) {
      return 'Age should be greater than 18';
    } else if (int.parse(month) == 02 && int.parse(day) == 31) {
      return 'day is invalid';
    }
    // if its today's date then its invalid
    else if (int.parse(day) >= now.day &&
        int.parse(month) >= now.month &&
        int.parse(year) >= now.year) {
      return 'Please enter valid date';
    }
    return null;
  }

  static String? dateValidator(String value, {bool shouldBeAdult = false}) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);

    String str1 = value;
    List<String> str2 = str1.split('-');
    String day = str2.isNotEmpty ? str2[0] : '';
    String month = str2.length > 1 ? str2[1] : '';
    String year = str2.length > 2 ? str2[2] : '';
    if (value.isEmpty) {
      return 'Date is required';
    } else if (value.length != 10) {
      return "Please enter valid date";
    } else if (int.parse(day) > 31) {
      return 'Day is invalid';
    } else if (int.parse(month) > 12) {
      return 'Month is invalid';
    } else if ((int.parse(year) < int.parse(formatted))) {
      return 'Year is invalid';
    } else if (int.parse(month) == 02 && int.parse(day) == 31) {
      return 'Day is invalid';
    } else {
      DateFormat format = DateFormat("dd-MM-yyyy");
      DateTime sddateTime = format.parse(value);
      if (sddateTime.isBefore(now) || sddateTime.isAtSameMomentAs(now)) {
        return 'Date is invalid';
      }
    }
    return null;
  }

  static String? validatePasswordField(String? validatorString, String? value) {
    if (value == null || value.trim().isEmpty) {
      return validatorString;
    }
    if (value.length < 7) {
      return 'should be atleast 8 character';
    }
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(value)) {
      return 'Password must include at least 1 uppercase, numeric and special character';
    }
    return null;
  }

  static String? matchPasswordField(
      String? validatorString, String? value, String? password) {
    if (value == null || value.trim().isEmpty) {
      return validatorString;
    }
    if (value != password) {
      return 'Password does not match';
    }
    if (value.length < 7) {
      return 'Should be atleast 8 character';
    }
    if (!RegExp(
            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
        .hasMatch(value)) {
      return 'Password must include at least 1 uppercase, numeric and special character';
    }
    return null;
  }

//   static String? issueExpiryDateValidator(String value,
//       {
//         String? emptyMessage,
//         required bool isIssueDate}) {
//     final DateTime now = DateTime.now();
//     final DateFormat formatter = DateFormat('yyyy');
//     final String formatted = formatter.format(now);
//     String str1 = value;
//     List<String> str2 = str1.split('-');
//     String day = str2.isNotEmpty ? str2[0] : '';
//     String month = str2.length > 1 ? str2[1] : '';
//     String year = str2.length > 2 ? str2[2] : '';
//     if (value.isEmpty) {
//       return emptyMessage ?? "Please enter valid date";
//     } else if (value.length != 10) {
//       return "Please enter valid date";
//     } else if (int.parse(day) > 31) {
//       return 'Month is invalid';
//     } else if (int.parse(month) > 12) {
//       return 'Day is invalid';
//     } else if (int.parse(year) > int.parse(formatted)) {
//       return null;
//   }
// }
}
