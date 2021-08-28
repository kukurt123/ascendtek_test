import 'package:flutter/widgets.dart';

class Streams extends StatefulWidget {
  Streams({Key? key, required this.child, required this.stream})
      : super(key: key);

  final Widget child;
  final Stream<Object> stream;

  @override
  _StreamsState createState() => _StreamsState();
}

class _StreamsState extends State<Streams> {
  dynamic data;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.stream,
        builder: (context, snapshot) {
          data = snapshot.data;
          return widget.child;
        });
  }
}
