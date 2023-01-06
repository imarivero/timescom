  // DateTime beginningOfWeek(DateTime date) {
  //   int daysToSubtract = (date.weekday % 7) - 1;
  //   return date.subtract(Duration(days: daysToSubtract));
  // }

  // DateTime endOfWeek(DateTime date) {
  //   int daysToAdd = 7 - date.weekday % 7;
  //   return date.add(Duration(days: daysToAdd));
  // }

extension DateTimeExtension on DateTime{

  DateTime  get beginningOfWeek {
    DateTime date = this;
    // Si ya es domingo, el inicio de semana fue el lunes anterior
    int daysToSubtract = date.weekday == 7 ? 6 : (date.weekday % 7) - 1;
    return date.subtract(Duration(days: daysToSubtract));
  }

  DateTime get endOfWeek {
    DateTime date = this;
    // Si ya es domingo, el fin de esa semana es ese mismo dia
    int daysToAdd = date.weekday == 7 ? 0 : 7 - date.weekday % 7;
    return date.add(Duration(days: daysToAdd));
  }

  int get weekOfMonth {
    var date = this;
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }

  String get nombreDia{
    DateTime date = this;
    switch (date.weekday) {
      case 1:
        return 'Lu';
      case 2:
        return 'Ma';
      case 3:
        return 'Mi';
      case 4:
        return 'Ju';
      case 5:
        return 'Vi';
      case 6:
        return 'Sa';
      case 7:
        return 'Do';
      default:
        return 'error';
    }
  }
  
}