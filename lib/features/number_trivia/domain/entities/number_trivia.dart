import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NumberTrivia extends Equatable {
  final int number;
  final String text;

  const NumberTrivia({
    @required this.number,
    @required this.text,
  });

  @override
  List<Object> get props => [number, text];
}
