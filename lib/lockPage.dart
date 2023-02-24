import 'package:flutter/material.dart';

class Lock extends StatefulWidget {
  const Lock({Key? key}) : super(key: key);

  @override
  State<Lock> createState() => _LockState();
}

class _LockState extends State<Lock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lock'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Lock Page')
            ],
          ),
        )
    );
  }
}
