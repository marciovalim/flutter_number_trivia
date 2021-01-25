import 'package:flutter/material.dart';

class TriviaButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final Function onPressed;

  const TriviaButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    @required this.color,
    @required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
    );
  }
}
