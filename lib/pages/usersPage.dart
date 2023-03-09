import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iot_project/constaints.dart';
import 'package:iot_project/homeApp.dart';
import 'package:iot_project/main.dart';
import 'package:iot_project/models/user_model.dart';
import 'package:iot_project/pages/httpRequest.dart';
import 'package:iot_project/theme/colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:http/http.dart' as http;


/*
Future<bool> fetchUsers() async {

  final response = await http.get(
      Uri.parse(server+'users'),
    headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImlsaWFzcyIsInBlcm1pc3Npb25zIjpbImxvY2siLCJ1bmxvY2siXSwicm9sZSI6ImFkbWluIiwiaWF0IjoxNjc4MjAwNjY5fQ.dv7tlvRxo2ucA_ZyCZMx8Jn6bx8risht2JT0XKklevo',
    }
  );

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    List<dynamic> data = jsonDecode(response.body);
    print(data);
    return data;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load album');
  }
}
*/
class User {
  final String id;
  final String username;
  final List<String> permissions;
  final String profilePictureUrl;
  bool allowed;

  changePrivelege() {
    allowed = !allowed;
  }

  User({required this.id,required this.username, required this.profilePictureUrl, required this.allowed, required this.permissions});
}

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersState();
}



class _UsersState extends State<UsersPage> {

   List<UserModel> users = [
    /*
    User(
        username: 'Aissam Boussoufiane',
        profilePictureUrl: 'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg?w=1060&t=st=1677275370~exp=1677275970~hmac=11c7e160ba4de52cd2255bdc2a115ef1811746dc9070b55c497507e8e953e182',
        allowed: true,
    ),
    User(
        username: 'Iliyas Essouiry',
        profilePictureUrl: 'https://img.freepik.com/premium-photo/portrait-young-man-white-backdrop_23-2148043786.jpg?w=1380',
      allowed: true,
    ),
    User(
        username: 'Hatim ELmharzi',
        profilePictureUrl: 'https://img.freepik.com/free-photo/portrait-good-looking-nordic-unshaven-man-with-fashionable-hairdo-posing_176420-15809.jpg?w=1380&t=st=1677275916~exp=1677276516~hmac=e506cd5791706fd15d73c33097251cc13a98e18902a3b23e3b42f12dc04286d4',
        allowed: false,
    ),

     */
  ];

  final TextEditingController filterController = TextEditingController();
  List<UserModel> filtredUsers = [];

   Future<List<UserModel>> getUsersApi() async {
     final response = await http.get(Uri.parse('https://mocki.io/v1/e15ed5ae-ec09-4e8d-9dfb-acae61218ee7')) ;
     var data = jsonDecode(response.body.toString());
     print(data);
     if(response.statusCode == 200){
       users.clear();
       int index = 0;
       for(Map i in data){
         users.add(UserModel.fromJson(i));
         print(UserModel.fromJson(i).username);
       }
       return users ;
     }else {
       return users ;
     }
   }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filtredUsers = users;
    // filtredUsers = users;
    // loadData();
   // getUsersApi();
  }


  Future<void> loadData() async {
    // Load your data here
    dynamic fetchedData = AuthenticationProvider.getApiRequest('users', {});
    print(fetchedData[0]);
    List<UserModel> newUsers = [];
    for(int i=0; i<fetchedData.length;i++) {
      /* Map<String, dynamic> userData =  fetchedData[i];
      print(fetchedData[i]);
      users.add(User(id: userData['id'], username: userData['username'], profilePictureUrl: '', allowed: true, permissions: userData['permission']));
    */
    }

    print(users);
    setState(() {
     users = newUsers;
    });
  }

  void filterUsersByName(String username) {
    setState(() {
       filtredUsers = users.where((user) => user.username!.toLowerCase().contains(username.toLowerCase())).toList();
    });
  }
  void printHello() {
    print('HATIM ZAMEL');
  }


  @override
  Widget build(BuildContext context) {
   // fetchAlbums();

    return Scaffold(
        backgroundColor: primary,
        body: getBody()
    );
    /*
    return FutureBuilder<String>(
      future: AuthenticationProvider.getApiRequest('users', {}),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          return Scaffold(
              backgroundColor: primary,
              body: getBody()
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
    return Scaffold(
        backgroundColor: primary,
        body: getBody()
    );

     */
  }

  Widget getBody() {
   /* dynamic response = AuthenticationProvider.getApiRequest('users', {});
    print(response);

    */
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
                child: FutureBuilder(
                  future: getUsersApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator(
                        backgroundColor: primary,
                      );
                    } else {
                      return   ListView.builder(
                        shrinkWrap: true,
                        itemCount: filtredUsers.length,
                        itemBuilder: (context, index) {
                          final isAllowedColor = filtredUsers[index].allowed ?? false  ? Colors.green : Colors.red;
                          final String isAllowedText = filtredUsers[index].allowed ?? false ? 'Allowed' : 'Not Allowed';
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
                                                child:  Icon(
                                                  Icons.person,
                                                  size: 40,
                                                  color: Colors.orangeAccent,
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
                                                      filtredUsers[index].username ?? '',
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
                      );
                    }
                  },
                )
              ,
              )
            ],
          ),
        )
    );
  }
}



class UserPage extends StatefulWidget {
  final UserModel user;

  const UserPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {

    String changeUserPrivilege = widget.user.allowed ?? false ? 'Not Allowed' : 'Allowed';
    Color isAllowedColor = widget.user.allowed ?? false ? Colors.green : Colors.red;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username ?? ''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 40,
              color: Colors.orangeAccent,
            ),
            SizedBox(height: 16),
            Text(widget.user.username ?? '', style: TextStyle(fontSize: 30)),
            ElevatedButton(
              onPressed: () {
                  setState(() {
                    widget.user.changePrivilege();
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



