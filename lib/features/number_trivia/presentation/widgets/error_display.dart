import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;

  const ErrorDisplay({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 20,
            color: Colors.red.shade500,
          ),
        ),
      ),
    );
  }
}
