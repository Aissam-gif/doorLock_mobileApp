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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child:   SizedBox(
                  width: 230,
                  height: 50,
                  child:ElevatedButton(
                    onPressed: () {},
                    child: const Text('Turn On'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child:  SizedBox(
                  width: 230,
                  height: 50,
                  child:ElevatedButton(
                    onPressed: () {},
                    child: const Text('Turn Off'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
