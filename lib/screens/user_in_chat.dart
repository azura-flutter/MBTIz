import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/screens/ChatPage.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trafit/util/const.dart';
import 'package:trafit/util/travel_spots.dart';

ApiService apiService = new ApiService();
SharedPreferences sharedPreferences;
String userName;

Future<List> call() async {
  sharedPreferences = await SharedPreferences.getInstance();
  String _id = sharedPreferences.getString('id');
  userName = sharedPreferences.getString('username');
  return apiService.user_in_room(_id);
}

class userInChatScreen extends StatefulWidget {
  @override
  _userInChatScreenState createState() => _userInChatScreenState();
}

class _userInChatScreenState extends State<userInChatScreen> {
  bool isFav = false;
  Future<List> rooms;

  @override
  void initState() {
    super.initState();
    rooms = call();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: rooms,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return body(snapshot.data);
          } else {
            return Text('');
          }
        });
  }

  Widget body(List rooms) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
        child: ListView(
          children: <Widget>[
            Text(
              '참여 채팅 (${rooms.length}개)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: rooms == null ? 0 : rooms.length,
                itemBuilder: (BuildContext context, int index) {
                  if (rooms.length != 0) {
                    Map chatroom = rooms[index];
                    DateTime startTime = DateTime(
                        0,
                        int.parse(chatroom['start_date'].substring(0, 2)),
                        int.parse(chatroom['start_date'].substring(2, 4)));
                    String start =
                        DateFormat('M월d일').format(startTime).toString();
                    DateTime endTime = DateTime(
                        0,
                        int.parse(chatroom['end_date'].substring(0, 2)),
                        int.parse(chatroom['end_date'].substring(2, 4)));
                    String end = DateFormat('M월d일').format(endTime).toString();
                    String spot =
                        travel_spots[int.parse(chatroom['category']) - 1]
                            ['name'];
                    ImageProvider c;
                    if (chatroom['img'] == 'x') {
                      if (chatroom['bossmbti'] != null) {
                        c = Image.asset(
                                'assets/mbti/' + chatroom['bossmbti'] + '.png')
                            .image;
                      } else {
                        c = Image.asset('assets/person.png').image;
                      }
                    } else {
                      c = CachedNetworkImageProvider(
                          'http://$myIP:3001/${chatroom['img']}');
                    }
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: ListTile(
                        leading: CircleAvatar(radius: 25.0, backgroundImage: c),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ChatPage(
                                    chatroom['room_num'], chatroom['category']);
                              },
                            ),
                          );
                        },
                        title: Column(children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Row(
                                    children: [
                                      Text("${chatroom['bossname']}"),
                                      Text("   $spot",
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Constants.lightAccent)),
                                    ],
                                  )),
                                  IconButton(
                                    icon: Icon(
                                      Icons.highlight_off,
                                    ),
                                    iconSize: 25,
                                    color: Colors.grey,
                                    onPressed: () async {
                                      sharedPreferences =
                                          await SharedPreferences.getInstance();

                                      String id =
                                          sharedPreferences.getString('id');

                                      apiService.leaveRoom(
                                          id,
                                          chatroom['room_num'],
                                          chatroom['boss'] == id);

                                      setState(() {
//                                            apiService.leaveRoom(name, chatroom['room_num']);
                                        rooms.removeAt(index);
                                      });
                                    },
                                  )
                                ],
                              ))
                        ]),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  chatroom['date'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                children: [
                                  Text("$start ~ $end",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        MediaQuery.of(context)
                                            .devicePixelRatio /
                                        5.0,
                                    child: Text(
                                      chatroom['comment'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else
                    return SizedBox(height: 0.0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
