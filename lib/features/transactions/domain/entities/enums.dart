import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CategoryEnum {
  food,
  clothing,
  entertainment,
  education,
  health,
  transport,
  salary,
  sent,
  received,
  other,
}

enum TransactionType {
  income,
  expense,
}

extension EnumExtension on Enum {
  String get name {
    return toString().split('.').last;
  }
}

extension TransactionTypeExtension on TransactionType {
  Color get color {
    switch (this) {
      case TransactionType.income:
        return Colors.greenAccent;
      case TransactionType.expense:
        return Colors.redAccent;
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionType.income:
        return FontAwesomeIcons.moneyBills;
      case TransactionType.expense:
        return FontAwesomeIcons.buildingColumns;
    }
  }

  String get operation {
    switch (this) {
      case TransactionType.income:
        return '+';
      case TransactionType.expense:
        return '-';
    }
  }
}

extension CategoryEnumExtension on CategoryEnum {
  IconData get icon {
    switch (this) {
      case CategoryEnum.food:
        return Icons.fastfood;
      case CategoryEnum.clothing:
        return Icons.shopping_bag;
      case CategoryEnum.entertainment:
        return Icons.movie;
      case CategoryEnum.education:
        return Icons.school;
      case CategoryEnum.health:
        return Icons.local_hospital;
      case CategoryEnum.transport:
        return Icons.directions_car;
      case CategoryEnum.salary:
        return Icons.money;
      case CategoryEnum.sent:
        return Icons.call_made;
      case CategoryEnum.received:
        return Icons.call_received;
      case CategoryEnum.other:
        return Icons.question_mark;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case CategoryEnum.food:
        return Colors.orange;
      case CategoryEnum.clothing:
        return Colors.blue;
      case CategoryEnum.entertainment:
        return Colors.purpleAccent;
      case CategoryEnum.education:
        return Colors.orangeAccent;
      case CategoryEnum.health:
        return Colors.pinkAccent;
      case CategoryEnum.transport:
        return Colors.deepOrangeAccent;
      case CategoryEnum.salary:
        return Colors.green;
      case CategoryEnum.sent:
        return Colors.redAccent;
      case CategoryEnum.received:
        return Colors.indigoAccent;
      case CategoryEnum.other:
        return Colors.grey;
    }
  }
}
