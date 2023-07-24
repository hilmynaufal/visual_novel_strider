import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visual_novel_strider/widgets/vn_detail.dart';

class CounterWidget extends StatefulWidget {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
  }

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: ${widget._counter}'),
        ElevatedButton(
          onPressed: () {
            
          },
          child: Text('Increment'),
        ),
      ],
    );
  }
}
