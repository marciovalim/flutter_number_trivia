import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/widgets/error_display.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/widgets/initial_display.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/widgets/loaded_display.dart';
import 'package:flutter_number_trivia/features/number_trivia/presentation/widgets/loading_display.dart';

class TriviaDisplay extends StatelessWidget {
  const TriviaDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          if (state is NumberTriviaInitial) {
            return InitialDisplay();
          }
          if (state is NumberTriviaLoading) {
            return LoadingDisplay();
          }
          if (state is NumberTriviaLoaded) {
            return LoadedDisplay(numberTrivia: state.numberTrivia);
          }
          if (state is NumberTriviaError) {
            return ErrorDisplay(message: state.message);
          }

          throw UnimplementedError('$state view not implemented');
        },
      ),
    );
  }
}
