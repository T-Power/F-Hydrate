extension DateHelperExt on DateTime {
  /**
   * Extension method to add a simple formatting functionality to DateTime: Formats DateTime as 'dd.MM.yyyy'.
   */
  String toDateString() {
    return '${DateHelper.padZero(this.day)}.${DateHelper.padZero(this.month)}.${this.year}';
  }

  /**
   * Extension method to add a simple formatting functionality to DateTime: Formats DateTime as 'dd.MM.yyyy HH:mm' (default) or with seconds=true as 'dd.MM.yyyy HH:mm:ss'.
   */
  String toDateTimeString({bool? seconds}) {
    String result =
        '${this.toDateString()} ${DateHelper.padZero(this.hour)}:${DateHelper.padZero(this.minute)}';
    if (seconds != null && seconds) {
      result = '$result:${DateHelper.padZero(this.second)}';
    }
    return result;
  }

  /**
   * Extension method to add a simple formatting functionality to DateTime: Formats DateTime as 'yyyy-MM-dd'.
   */
  String toBackendDateString(){
    return '${DateHelper.padZero(this.year)}-${DateHelper.padZero(this.month)}-${this.day}';
  }
}

class DateHelper {
  /**
   * Adds a leading 0 to small time numbers. E.g. input of 9 (minutes) will result in 09 as output.
   */
  static String padZero(int time) {
    if (time < 10) {
      return '0$time';
    }
    return '$time';
  }
}
