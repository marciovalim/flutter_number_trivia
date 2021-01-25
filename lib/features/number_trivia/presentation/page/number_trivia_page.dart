import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia/di/di.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/page/trivia_display.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/page/trivia_input.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Number Trivia'),
      ),
      body: BlocProvider(
        create: (_) => getIt<NumberTriviaBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              TriviaDisplay(),
              SizedBox(height: 20),
              TriviaInput(),
            ],
          ),
        ),
      ),
    );
  }
}
