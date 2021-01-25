import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_number_trivia/core/utils/presentation/stateful.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/controllers/trivia_input_controller.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/widgets/trivia_button.dart';

class TriviaInput extends StatelessWidget {
  TriviaInput({
    Key key,
  }) : super(key: key);

  final _controller = TriviaInputController();

  @override
  Widget build(BuildContext context) {
    return Stateful(
      dispose: _controller.dispose,
      child: Column(
        children: [
          TextField(
            controller: _controller.textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter number here',
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange.shade600, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepOrange.shade700,
                  width: 1.25,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TriviaButton(
                  text: 'Search Trivia',
                  color: Colors.orange.shade600,
                  textColor: Colors.white,
                  onPressed: () => _controller.searchTrivia(context),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: TriviaButton(
                  text: 'Random Trivia',
                  color: Colors.deepOrange.shade400,
                  textColor: Colors.white,
                  onPressed: () => _controller.getRandomTrivia(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
