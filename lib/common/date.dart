class Date {
  int month = 1;
  int day = 1;
  int year = 1999;
  int hour = 0;
  int minute = 0;
  List<String> months = [
    "index 0 is null",
    "January",
    "Febuary",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  Date(
      {required this.month,
      required this.day,
      required this.year,
      required this.hour,
      required this.minute});

  factory Date.fromDate(DateTime date) {
    return Date(
      month: date.month,
      day: date.day,
      year: date.year,
      hour: date.hour,
      minute: date.minute,
    );
  }

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      month: json['month'] as int,
      day: json['day'] as int,
      year: json['year'] as int,
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'day': day,
      'year': year,
      'hour': hour,
      'minute': minute
    };
  }

  @override
  String toString() {
    return "${months[month]} $day, $year at $hour:$minute";
  }
}
