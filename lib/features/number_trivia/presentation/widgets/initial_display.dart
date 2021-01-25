import 'package:flutter/material.dart';

class InitialDisplay extends StatelessWidget {
  const InitialDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Type an integer to get a trivia!',
        style: TextStyle(
          fontSize: 25,
          color: Colors.orange.shade900,
        ),
      ),
    );
  }
}
