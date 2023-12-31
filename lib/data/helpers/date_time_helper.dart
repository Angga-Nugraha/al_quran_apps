import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime format() {
    //DATE AND TIME FORMAT
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecifics = '18:00:00';
    final completeFormat = DateFormat('y/M/d H:m:s');

    //TODAY FORMAT
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = '$todayDate $timeSpecifics';
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // TOMOROW FORMAT
    var formated = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formated);
    final tomorrowDateAndTime = '$tomorrowDate $timeSpecifics';
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    var result = now.isAfter(resultToday) ? resultTomorrow : resultToday;
    debugPrint(result.toString());

    return result;
  }
}
