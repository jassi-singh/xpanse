import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'enums.dart';

class TransactionCategory extends Equatable {
  final String name;
  final Color backgroundColor;
  final IconData icon;
  final CategoryEnum category;

  const TransactionCategory({
    required this.name,
    required this.backgroundColor,
    required this.icon,
    required this.category,
  });

  @override
  List<Object?> get props => [name, backgroundColor, icon, category];
}
