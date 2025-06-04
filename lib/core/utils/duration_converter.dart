class DurationConverter {
  static int convertToDays(String input) {
    final RegExp regex = RegExp(r'^(\d+)([MY])$');
    final match = regex.firstMatch(input.toUpperCase());

    if (match == null) {
      throw ArgumentError(
          'Invalid format. Use number followed by M or Y (e.g., 3M, 1Y)');
    }

    final int value = int.parse(match.group(1)!);
    final String unit = match.group(2)!;

    switch (unit) {
      case 'M':
        return value * 30;
      case 'Y':
        return value * 365;
      default:
        throw ArgumentError('Unknown time unit: $unit');
    }
  }
}
