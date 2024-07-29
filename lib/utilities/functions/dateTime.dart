import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// format time of the day

String formatTimeOfDay(TimeOfDay tod) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}

// current time

currentTime({DateTime? timeInputed}) {
  // DateTime now = timeInputed.toLocal() ?? DateTime.now();
  // TimeOfDay timeNow = TimeOfDay.fromDateTime(now);
  // var time = formatTimeOfDay(timeNow);
  String timeString = DateFormat('HH:mm:ss').format(timeInputed!.toLocal());
  DateTime time = DateFormat('HH:mm:ss').parse(timeString);
  String formattedTime = DateFormat('h:mm a').format(time);
  return formattedTime;
}

// convert 12 hours time to 24 hours
dateTime24(String time) {
  // time in this format 6:45AM or 6:45PM
  DateTime date1 = DateFormat("hh:mma").parse(time.replaceAll(" ", ""));
  TimeOfDay timeNow =
      TimeOfDay.fromDateTime(date1); // returns e.g TimeOfDay(18:45)
  var value = timeNow.toString().split("").sublist(10, 15); // returns [18:45]
  var concatenate = StringBuffer();
  // with the function below, you will convert the list to string
  value.forEach((item) {
    concatenate.write(item);
  });
  debugPrint(concatenate.toString());
  return concatenate;
}

// convert 24 hours to 12 hours time (not done yet)
dateTime12hours() {
  Map growableMap = {}; // this map is a growable map
  List<String> questions = [
    "1",
    "3",
    "4",
    "6",
    "6",
    "1",
    "0"
  ]; // this is the list of question
  List mapCounter = List.generate(
      questions.length,
      (index) =>
          index +
          1); // i am creating list of int, from the length of the question and increasing the result by 1, to remove 0 index and start from 1

  // i am using the mapCounter, using the integer as key and question  value as value
  for (int index in mapCounter) {
    growableMap[index] = questions[index - 1];
  }
  // after the above function runs, the map will be filled with the new value
  debugPrint(growableMap.toString());
}

// current date
currentDate(value) {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('EEEE d, MMMM y ').format(now);
  String dayMonth = DateFormat('EEEE d, MMMM ').format(now);
  String justDay = DateFormat('d').format(now);
  String justMonth = DateFormat('MMMM ').format(now);
  String justYear = DateFormat('y').format(now);
  String monthYear = DateFormat(' MMMM y ').format(now);
  if (value == 'day') return justDay;
  if (value == 'full date') return formattedDate;
  if (value == 'year') return justYear;
  if (value == 'month') return justMonth;
  if (value == 'day and month') return dayMonth;
  if (value == 'month and year') return monthYear;
}

getCurrentDate(DateTime now, String value) {
  String formattedDate = DateFormat('d, MMMM y ').format(now);
  String dayMonth = DateFormat('EEEE d, MMMM ').format(now);
  String commaSeparated = DateFormat("dd/MM/yyyy").format(now);
  String dashSeparated = DateFormat("dd-MM-yyyy").format(now);
  String invertedDashSeparated = DateFormat("yyyy-MM-dd").format(now);
  String justMonth = DateFormat('MMMM ').format(now);
  String monthNumber = DateFormat('M').format(now);
  String justDay = DateFormat('d').format(now);
  String justYear = DateFormat(' y ').format(now);
  String monthYear = DateFormat(' MMMM y ').format(now);
  if (value == 'full date') return formattedDate;
  if (value == 'comma separated') return commaSeparated;
  if (value == 'dash separated') return dashSeparated;
  if (value == 'invertedDashSeparated') return invertedDashSeparated;
  if (value == 'day') return justDay;
  if (value == 'year') return justYear;
  if (value == 'month') return justMonth;
  if (value == 'monthNumber') return monthNumber;
  if (value == 'day and month') return dayMonth;
  if (value == 'month and year') return monthYear;
}

Map<int, int> monthList(bool isLeapYear) {
  return {
    1: 31,
    2: isLeapYear == true ? 28 : 27,
    3: 31,
    4: 30,
    5: 30,
    6: 30,
    7: 30,
    8: 30,
    9: 30,
    10: 30,
    11: 30,
    12: 30
  };
}

int calculateMonth(DateTime to) {
  DateTime from = DateTime.now();
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  debugPrint((to.difference(from).inHours / 24).round().toString());
  return (to.difference(from).inHours / 24).round();
}

String? convertStringDate(String? date) {
  if (date == null) {
    return null;
  }
  final yMd = date.split(' ')[0].split('-');
  final DateTime dateTime =
      DateTime(int.parse(yMd[0]), int.parse(yMd[1]), int.parse(yMd[2]));
  return DateFormat.yMMMd().format(dateTime.toLocal());
}

DateTime? dateTimeConvertStringDate(String? date, {bool getTime = false}) {
  if (date == null) {
    return null;
  }
  final yMd = date.split(' ')[0].split('-');
  final hMs = date.split(' ')[1].split(':');
  final DateTime dateTime = getTime
      ? DateTime(int.parse(yMd[0]), int.parse(yMd[1]), int.parse(yMd[2]),
          int.parse(hMs[0]), int.parse(hMs[1]), int.parse(hMs[2]))
      : DateTime(int.parse(yMd[0]), int.parse(yMd[1]), int.parse(yMd[2]));
  return dateTime;
}

convertZDate(String date) {
  String dateString = date;
  // parse the date string into a DateTime object
  DateTime dateTime = DateTime.parse(dateString);

  // format the date using intl package
  String formattedDate = DateFormat("dd MMM yy").format(dateTime.toLocal());
  return formattedDate;
}

DateTime? dateTimeConvertSlashDate(String? date) {
  if (date == null) {
    return null;
  }
  final yMd = date.split('/');
  final DateTime dateTime =
      DateTime(int.parse(yMd[0]), int.parse(yMd[1]), int.parse(yMd[2]));
  return dateTime;
}

int calculateDurationinDays(String? from, String? to) {
  if (from == null || to == null) {
    return 0;
  } else {
    final fromYMd = from.split(' ')[0].split('-');
    final toYMd = to.split(' ')[0].split('-');
    final DateTime fromDateTime = DateTime(
        int.parse(fromYMd[0]), int.parse(fromYMd[1]), int.parse(fromYMd[2]));
    final DateTime toDateTime =
        DateTime(int.parse(toYMd[0]), int.parse(toYMd[1]), int.parse(toYMd[2]));
    int days = toDateTime.difference(fromDateTime).inDays + 1;
    return days;
  }
}
