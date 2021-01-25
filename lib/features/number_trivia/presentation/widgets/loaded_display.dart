import 'package:flutter/material.dart';
import 'package:flutter_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

class LoadedDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const LoadedDisplay({Key key, @required this.numberTrivia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              numberTrivia.text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
