// ignore_for_file: avoid_print

/// DateTime Formatter util class
///
/// https://www.kindacode.com/article/ways-to-format-datetime-in-flutter/#Using_self-written_code
class DateTimeFormatter {
  // Define a simple format function from scratch
  static String simplyFormat({
    required DateTime dateTime,
    bool dateOnly = false,
  }) {
    String year = dateTime.year.toString();

    // Add '0' on the left if month is from 1 to 9
    String month = dateTime.month.toString().padLeft(2, '0');

    // Add '0' on the left if day is from 1 to 9
    String day = dateTime.day.toString().padLeft(2, '0');

    // Add '0' on the left if hour is from 1 to 9
    String hour = dateTime.hour.toString().padLeft(2, '0');

    // Add '0' on the left if minute is from 1 to 9
    String minute = dateTime.minute.toString().padLeft(2, '0');

    // Add '0' on the left if second is from 1 to 9
    String second = dateTime.second.toString();

    // If you only want year, month, and date
    if (dateOnly == false) {
      return '$year-$month-$day $hour:$minute:$second';
    }

    // return the 'yyyy-MM-dd HH:mm:ss' format
    return '$year-$month-$day';
  }
}

// Test our function
void main() {
  DateTime currentTime = DateTime.now();

  // Full date and time
  final result1 = DateTimeFormatter.simplyFormat(
    dateTime: currentTime,
  );
  print(result1); // 2023-01-08 06:10:13

  // Date only
  final result2 = DateTimeFormatter.simplyFormat(
    dateTime: currentTime,
    dateOnly: true,
  );
  print(result2); // 2023-01-08

  // Kindacode.com
}
