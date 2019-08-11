import 'package:intl/intl.dart';

class DatetimeUtil{
  static const String DATE_TIME_FULL = 'yyyy-MM-dd HH:mm:ss';
  static const String DATE_FORMAT_RAW = 'yyyy-MM-dd';
  static const String DATE_FORMAT_VIEW = 'dd MMM yyyy';
  static const String DATE_FORMAT_SHORT = 'dd/MM/yy';
  static const String TIME_FORMAT_VIEW = 'HH:mm';
  static const String LOCALE_FORMAT = 'en_US';

  static const int SAME_DATE = 0;
  static const int DATE_IS_GREATER = 1;
  static const int DATE_IS_SMALLER = 2;

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

  static String convertDateToShort(String dateTime){
    return DateFormat(DATE_FORMAT_SHORT, LOCALE_FORMAT).format(convertStringToDatetime(dateTime)).toString();
  }

  // CONVERT TIME
  static String convertTimeToView(String dateTime){
    return DateFormat(TIME_FORMAT_VIEW, LOCALE_FORMAT).format(convertStringToDatetime(dateTime)).toString();
  }

  // COMPARE DATE
  static int compareDate(String date1, String date2){    
    switch(convertViewToDate(date1).compareTo(convertViewToDate(date2))){
      case 0:
        return SAME_DATE;
      case 1:
        return DATE_IS_GREATER;
      default:
        return DATE_IS_SMALLER;
    }    
  }
}