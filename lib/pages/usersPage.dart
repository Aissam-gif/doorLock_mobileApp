import 'package:flutter/material.dart';
import 'package:iot_project/main.dart';
import 'package:iot_project/theme/colors.dart';

class User {
  final String fullName;
  final String profilePictureUrl;
  bool allowed;

  changePrivelege() {
    allowed = !allowed;
  }

  User({required this.fullName, required this.profilePictureUrl, required this.allowed});
}

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersState();
}

class _UsersState extends State<UsersPage> {
  final List<User> users = [
    User(
        fullName: 'Aissam Boussoufiane',
        profilePictureUrl: 'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?w=1060&t=st=1677275370~exp=1677275970~hmac=11c7e160ba4de52cd2255bdc2a115ef1811746dc9070b55c497507e8e953e182',
        allowed: true,
    ),
    User(
        fullName: 'Iliyas Essouiry',
        profilePictureUrl: 'https://img.freepik.com/premium-photo/portrait-young-man-white-backdrop_23-2148043786.jpg?w=1380',
      allowed: true,
    ),
    User(
        fullName: 'Hatim zamel',
        profilePictureUrl: 'https://img.freepik.com/free-photo/portrait-good-looking-nordic-unshaven-man-with-fashionable-hairdo-posing_176420-15809.jpg?w=1380&t=st=1677275916~exp=1677276516~hmac=e506cd5791706fd15d73c33097251cc13a98e18902a3b23e3b42f12dc04286d4',
        allowed: false,
    ),
  ];

  final TextEditingController filterController = TextEditingController();
  List<User> filtredUsers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filtredUsers = users;
  }

  void filterUsersByName(String _fullName) {
    setState(() {
      filtredUsers = users.where((user) => user.fullName.toLowerCase().contains(_fullName.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primary,
        body: getBody()
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20, left: 5, right: 5),
          child: Column(
            children: [
                TextField(
                  controller: filterController,
                  onChanged: filterUsersByName,
                  decoration: InputDecoration(
                    hintText: 'Search By Name',
                    prefixIcon: Icon(Icons.search),
                    fillColor: primary
                  ),
                ),
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filtredUsers.length,
                  itemBuilder: (context, index) {
                    final isAllowedColor = filtredUsers[index].allowed ? Colors.green : Colors.red;
                    final String isAllowedText = filtredUsers[index].allowed ? 'Allowed' : 'Not Allowed';
                    return  ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: grey.withOpacity(0.03),
                                      spreadRadius: 10,
                                      blurRadius: 3,
                                      // changes position of shadow
                                    ),
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, right: 20, left: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Center(
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(filtredUsers[index].profilePictureUrl),
                                          )
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: (size.width - 90) * 0.7,
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                filtredUsers[index].fullName,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: black,
                                                    fontWeight: FontWeight.bold),
                                              )
                                            ]),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(

                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(25),
                                                color: isAllowedColor
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserPage(user: filtredUsers[index]),
                            ));
                      },
                    );
                  },
                ),
              )
            ],
          ),
        )
    );
  }
}



class UserPage extends StatefulWidget {
  final User user;

  const UserPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {

    String changeUserPrivilege = widget.user.allowed ? 'Not Allowed' : 'Allowed';
    Color isAllowedColor = widget.user.allowed ? Colors.green : Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.fullName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.profilePictureUrl),
            ),
            SizedBox(height: 16),
            Text(widget.user.fullName, style: TextStyle(fontSize: 30)),
            ElevatedButton(
              onPressed: () {
                  setState(() {
                    widget.user.changePrivelege();
                  });
                },
              child: Text('Change to ' + changeUserPrivilege),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(isAllowedColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



