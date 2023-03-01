import 'package:flutter/material.dart';
import 'package:iot_project/constaints.dart';
import 'package:iot_project/theme/colors.dart';
import 'package:slidable_button/slidable_button.dart';

class Lock {
  bool lockState;
  String lockImage;

  changeLockState() {
    lockState = !lockState;
    if (lockState == true) {
      lockImage = LOCK_OPENED_IMAGE;
    } else {
      lockImage = LOCK_CLOSED_IMAGE;
    }
  }
  Lock({required this.lockState, required this.lockImage});
}

class LockPage extends StatefulWidget {
  const LockPage({Key? key}) : super(key: key);

  @override
  State<LockPage> createState() => _LockState();
}

class _LockState extends State<LockPage> {

  String result = "";
  Lock lock = Lock(lockState: false, lockImage: LOCK_CLOSED_IMAGE);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primary,
      body: getBody(),
    );
  }

  Widget getBody() {
    var lockColor = lock.lockState ? red : green;
    return SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                width: 250,
                height: 250,
                child: lock.lockState ? Icon(
                    Icons.lock_clock,
                  size: 250,
                  color: mainFontColor,
                ) : Icon(
                    Icons.lock_open,
                  size: 250,
                  color: mainFontColor,
                ),
              ),
              SizedBox(
                height: 50,
              ),

              Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 25),
                child:  HorizontalSlidableButton(
                  width: 400,
                  height: 60,
                  buttonWidth: 100.0,
                  color: mainFontColor,
                  buttonColor: buttoncolor,
                  dismissible: false,
                  label: Center(
                    child: Text(
                      "Slide Me",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            "Lock",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 25),
                          child: Text(
                            "Unlock",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        )

                      ],
                    ),
                  ),
                  onChanged: (position) {
                    setState(() {
                      if (position == SlidableButtonPosition.end) {
                        lock.changeLockState();
                        result = 'Lock is opened';
                      } else if (position != SlidableButtonPosition.sliding){
                        lock.changeLockState();
                        result = 'Lock is closed';
                      }
                    });
                  },
                ),
              ),

              Text(result,
              style: TextStyle(
                color: lockColor,
                fontSize: 16

              )
                ,)
            ],
          ),
        ));
  }
}
