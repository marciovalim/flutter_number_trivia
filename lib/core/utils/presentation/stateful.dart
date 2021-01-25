import 'package:flutter/material.dart';

class Stateful extends StatefulWidget {
  final Widget child;
  final Function initState;
  final Function didChangeDependencies;
  final Function dispose;

  const Stateful({
    Key key,
    @required this.child,
    this.dispose,
    this.initState,
    this.didChangeDependencies,
  }) : super(key: key);

  @override
  _StatefulState createState() => _StatefulState();
}

class _StatefulState extends State<Stateful> {
  @override
  void initState() {
    super.initState();
    widget.initState?.call();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.dispose?.call();
    super.dispose();
  }
}
