import 'package:flutter/material.dart';
import 'package:iot_project/constaints.dart';
import 'package:iot_project/pages/httpRequest.dart';
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
  Lock _lock = Lock(lockState: true, lockImage: LOCK_CLOSED_IMAGE);

  unlock() {
    setState(() {
      _lock.lockState = false;
      _lock.lockImage = LOCK_OPENED_IMAGE;
    });
  }

  lock() {
    setState(() {
      _lock.lockState = true;
      _lock.lockImage = LOCK_CLOSED_IMAGE;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: getBody(),
    );
  }

  Widget getBody() {
    var lockColor = _lock.lockState ? red : green;
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              child: _lock.lockState
                  ? Icon(
                      Icons.lock,
                      size: 250,
                      color: mainFontColor,
                    )
                  : Icon(
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
              child: HorizontalSlidableButton(
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
                    if (position == SlidableButtonPosition.start) {
                      AuthenticationProvider
                          .getMockApiRequest(
                              "https://mocki.io/v1/cbec8b3f-1f67-409d-87f9-4b20ce5ece03",
                              {}).then((value) => {
                            if (value != null)
                              {lock(), result = 'Lock is closed'}
                          });
                    } else if (position == SlidableButtonPosition.end) {
                      AuthenticationProvider
                          .getMockApiRequest(
                              "https://mocki.io/v1/97b2222d-9f27-4967-b416-fccd0e94d74d",
                              {}).then((value) => {
                            if (value != null)
                              {unlock(), result = 'Lock is opened'}
                          });
                    }
                  });
                },
              ),
            ),
            Text(
              result,
              style: TextStyle(color: lockColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
