String parseDate(String dateString) {
  var months = [
    "January",
    "February",
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
  DateTime date = DateTime.parse(dateString);
  return ("${date.day} ${months[date.month]}");
}
