import 'package:flutter/material.dart';

import 'features/number_trivia/presentation/page/number_trivia_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange.shade800,
        accentColor: Colors.orange.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}
