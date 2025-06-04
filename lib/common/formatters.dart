import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  /// Cleans a currency string (like ₹43,43,279.2) and converts to a double.
  double parseCurrency(String currencyString) {
    final cleaned = currencyString.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
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
  /// E.g. 123456.78 -> ₹1,23,456.78
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
      default:
        return 'Unknown';
    }
  }

  /// Converts ISO 8601 date string to 'dd-MMM-yyyy HH:mm:ss' format.
  String formatIsoToReadableDate(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('dd-MMM-yyyy HH:mm:ss').format(dateTime);
    } catch (e) {
      return isoString; // return original if parsing fails
    }
  }

  String formatIsoToNormalDate(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('dd-MMM-yyyy').format(dateTime); // Time removed
    } catch (e) {
      return isoString; // return original if parsing fails
    }
  }

  /// Converts ISO 8601 string to 'dd-MM-yyyy' format
  String formatIsoToDdMmYyyy(String isoString) {
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return isoString;
    }
  }
}
