import 'package:intl/intl.dart';

class DatetimeUtil{
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

  // CONVERT DATE
  static String convertDateToView(DateTime dateTime){
    return DateFormat(DATE_FORMAT_VIEW, LOCALE_FORMAT).format(dateTime).toString();
  }

  static String convertViewToDate(DateTime dateTime){
    return DateFormat(DATE_FORMAT_RAW, LOCALE_FORMAT).format(dateTime).toString();
  }

  // CONVERT TIME
  static String convertTimeToView(DateTime dateTime){
    return DateFormat(TIME_FORMAT_VIEW, LOCALE_FORMAT).format(dateTime).toString();
  }
}