import 'package:flutter/material.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/model/response/user_response.dart';

class MyInfoPage extends StatefulWidget {
  String accessToken;

  MyInfoPage({super.key, required this.accessToken});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  late Api api;
  late Future<UserResponse?> userResponse;

  @override
  void initState() {
    api = Api();
    userResponse = api.getMyInfo(widget.accessToken);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Me",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent,
          ),
        ),
        centerTitle: true,
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          FutureBuilder(
            future: userResponse,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return Expanded(child: renderUser(snapshot.data!));
                } else {
                  return Text('Something went error');
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget renderUser(UserResponse user) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Image.network(
          "https://cdn-icons-png.flaticon.com/512/1053/1053244.png",
          width: 100,
          height: 100,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            // Icon(Icons.person, color: Colors.pinkAccent),
            // SizedBox(width: 10),
            Text(
              user.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        Divider(height: 2),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.cake, color: Colors.pinkAccent),
            SizedBox(width: 10),
            Text("${user.age}"),
          ],
        ),

        SizedBox(height: 10),
        Row(
          children: [
            (user.isMale
                ? Icon(Icons.male_sharp, color: Colors.pinkAccent)
                : Icon(Icons.female_sharp, color: Colors.pinkAccent)),
            SizedBox(width: 10),
            Text(user.isMale ? 'Nam' : 'Nữ'),
          ],
        ),

        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.alternate_email_rounded, color: Colors.pinkAccent),
            SizedBox(width: 10),
            Text(user.email),
          ],
        ),

        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.phone, color: Colors.pinkAccent),
            SizedBox(width: 10),
            Text(user.phoneNumber),
          ],
        ),

        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.location_on_rounded, color: Colors.pinkAccent),
            SizedBox(width: 10),
            Text(user.address),
          ],
        ),

        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.book, color: Colors.pinkAccent),
            SizedBox(width: 10),
            Text(user.bio ?? ''),
          ],
        ),
      ],
    );
  }
}
