import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Test'),
          ),
          body: ListView(
            children: [
              Hero(
                tag: 'test',
                child: Text('Hello'),
              )
            ],
          )),
    );
  }
}
