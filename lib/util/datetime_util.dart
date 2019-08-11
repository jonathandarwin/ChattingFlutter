import 'package:intl/intl.dart';

class DatetimeUtil{
  static const String DATE_TIME_FULL = 'yyyy-MM-dd HH:mm:ss';
  static const String DATE_FORMAT_RAW = 'yyyy-MM-dd';
  static const String DATE_FORMAT_VIEW = 'dd MMM yyyy';
  static const String TIME_FORMAT_VIEW = 'HH:mm';
  static const String LOCALE_FORMAT = 'en_US';

  // GET DATE AND TIME
  static String getRawDate(){
    var date = DateTime.now();
    return DateFormat(DATE_FORMAT_RAW).format(date);
  }

  static String getDate(){
    var date = DateTime.now();
    return DateFormat(DATE_FORMAT_VIEW).format(date);
  }  

  static String getTime(){
    var date = DateTime.now();
    return DateFormat(TIME_FORMAT_VIEW).format(date);
  }

  // CONVERT STRING TO DATETIME
  static DateTime convertStringToDatetime(String datetime){
    return DateFormat(DATE_TIME_FULL, LOCALE_FORMAT).parse(datetime);
  }

  // CONVERT DATE
  static String convertDateToView(String dateTime){
    return DateFormat(DATE_FORMAT_VIEW, LOCALE_FORMAT).format(convertStringToDatetime(dateTime)).toString();
  }

  static String convertViewToDate(String dateTime){
    return DateFormat(DATE_FORMAT_RAW, LOCALE_FORMAT).format(convertStringToDatetime(dateTime)).toString();
  }

  // CONVERT TIME
  static String convertTimeToView(String dateTime){
    return DateFormat(TIME_FORMAT_VIEW, LOCALE_FORMAT).format(convertStringToDatetime(dateTime)).toString();
  }
}