import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaInputController {
  final _textController = TextEditingController();
  TextEditingController get textController => _textController;

  void searchTrivia(BuildContext context) {
    final event = GetNumberTriviaEvent(_textController.text);
    _addEvent(context, event);
    _clearTextField();
  }

  void getRandomTrivia(BuildContext context) {
    final event = GetRandomNumberTriviaEvent();
    _addEvent(context, event);
    _clearTextField();
  }

  void _addEvent(BuildContext context, NumberTriviaEvent event) {
    BlocProvider.of<NumberTriviaBloc>(context).add(event);
  }

  void _clearTextField() => _textController.clear();

  void dispose() => _textController.dispose();
}
