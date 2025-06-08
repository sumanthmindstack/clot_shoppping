import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../gen/assets.gen.dart';

class Formatters {
  /// Formats a number using K, M, B suffixes or comma separators.
  String formatNumber(num number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return NumberFormat('#,##0').format(number);
    }
  }

  /// Cleans and parses a currency string, including unit suffixes like K, L, Cr, B.
  double parseCurrency(String currencyString) {
    final cleaned = currencyString.trim().toUpperCase();
    final match = RegExp(r'^.*?([\d,.]+)\s*(K|L|CR|B)?$').firstMatch(cleaned);

    if (match == null) return 0.0;

    final numberPart = match.group(1)?.replaceAll(',', '') ?? '0';
    final unit = match.group(2) ?? '';

    final number = double.tryParse(numberPart) ?? 0.0;

    switch (unit) {
      case 'K':
        return number * 1000;
      case 'L':
        return number * 100000;
      case 'CR':
        return number * 10000000;
      case 'B':
        return number * 1000000000;
      default:
        return number;
    }
  }

  /// Formats a currency string into a shortened display (e.g. ₹4.3M).
  String formatCurrencyDisplay(String currencyString, {String symbol = '₹'}) {
    final number = parseCurrency(currencyString);
    return symbol + formatNumber(number);
  }

  /// Validates and formats a nullable DateTime to 'dd-MM-yyyy'.
  String formatDate(DateTime? date) {
    return DateFormat('dd-MM-yyyy').format(date ?? DateTime.now());
  }

  /// Capitalizes the first letter of each word in a string.
  String capitalizeWords(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  /// Returns the initials from a name (e.g. 'Sumanth Poojary' -> 'SP').
  String getInitials(String input) {
    return input
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .join();
  }

  /// Formats number to two decimal places.
  String formatTwoDecimals(num number) {
    return number.toStringAsFixed(2);
  }

  /// Formats a number into Indian currency style with rupee symbol and commas.
  String formatIndianCurrency(num number, {String symbol = '₹'}) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: symbol,
      decimalDigits: 2,
    );
    return formatter.format(number);
  }

  String maskAadhaar(String aadhaarNumber) {
    if (aadhaarNumber.length != 12) {
      return 'Invalid Aadhaar';
    }
    return 'XXXX-XXXX-${aadhaarNumber.substring(8)}';
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String getStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'submitted':
        return 'Successful';
      case 'rejected':
        return 'Rejected';
      case 'pending':
        return 'Pending';
      case 'created':
        return 'Created';
      default:
        return 'Unknown';
    }
  }

  Color getTransactionStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.blue;
      case 'failed':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      case 'created':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String getTransactionStatusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'Confirmed';
      case 'failed':
        return 'Failed';
      case 'pending':
        return 'Pending';
      default:
        return 'Unknown';
    }
  }

  SvgPicture getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return SvgPicture.asset(Assets.images.pendingState.path);
      case 'rejected':
      case 'failed':
        return SvgPicture.asset(Assets.images.orderFailedLogo.path);
      case 'confirmed':
      case 'submitted':
        return SvgPicture.asset(Assets.images.orderSuccess.path);
      default:
        return SvgPicture.asset(Assets.images.orderFailedLogo.path);
    }
  }

  Color getVertialMoreIconColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
      case 'failed':
        return Colors.red;
      default:
        return Colors.yellow;
    }
  }

  Icon getVerticalMoreIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return const Icon(Icons.check_circle, color: Colors.green, size: 24);
      case 'pending':
        return const Icon(Icons.access_time, color: Colors.orange, size: 24);
      case 'rejected':
      case 'failed':
        return const Icon(Icons.cancel, color: Colors.red, size: 24);
      default:
        return const Icon(Icons.more_vert, color: Colors.yellow, size: 24);
    }
  }

  /// Converts number based on unit passed: Thousands, Lakhs, Crores, Billions.
  String formatWithUnit(num value, String scale) {
    final formatter = NumberFormat.decimalPattern(); // Adds commas

    switch (scale) {
      case 'Thousands':
        return '₹${(value / 1000).toStringAsFixed(2)} K';
      case 'Lakhs':
        return '₹${(value / 100000).toStringAsFixed(2)} L';
      case 'Crores':
        return '₹${(value / 10000000).toStringAsFixed(2)} Cr';
      case 'Billion':
        return '₹${(value / 1000000000).toStringAsFixed(2)} B';
      case 'Actual':
      default:
        return "₹${formatter.format(value)}";
    }
  }

  /// Converts ISO 8601 date string to 'dd-MMM-yyyy HH:mm:ss' format.
  String formatIsoToReadableDate(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('dd-MMM-yyyy HH:mm:ss').format(dateTime);
    } catch (e) {
      return isoString;
    }
  }

  String formatIsoToNormalDate(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('dd-MMM-yyyy').format(dateTime);
    } catch (e) {
      return isoString;
    }
  }

  String formatIsoToDdMmYyyy(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return isoString;
    }
  }

  /// Formats a number adaptively: full number till 10k, then L/Cr.
  String formatAdaptiveUnit(num value, {String symbol = '₹'}) {
    if (value < 10000) {
      return "$symbol${NumberFormat.decimalPattern('en_IN').format(value)}";
    } else if (value >= 10000 && value < 100000) {
      return "$symbol${(value / 1000).toStringAsFixed(1)} K";
    } else if (value >= 100000 && value < 10000000) {
      return "$symbol${(value / 100000).toStringAsFixed(2)} L";
    } else {
      return "$symbol${(value / 10000000).toStringAsFixed(2)} Cr";
    }
  }
}
