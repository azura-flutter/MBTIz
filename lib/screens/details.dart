import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/screens/ChatPage.dart';
import 'package:trafit/screens/notifications.dart';
import 'package:trafit/util/travel_spots.dart';
import 'package:trafit/screens/post_screen.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

ApiService apiService = new ApiService();

Future<List> call(String category) async {
  return apiService.show_room(category);
}

class ProductDetails extends StatefulWidget {
  final String _name;
  final String _img;
  final String _category;

  ProductDetails(this._name, this._img, this._category);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFav = false;
  Future<List> rooms;

  @override
  void initState() {
    super.initState();
    rooms = call(widget._category);
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    double ratio = MediaQuery.of(context).devicePixelRatio;

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
    double phoneWidth = MediaQuery.of(context).size.width;
    double ratio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget._name + " 게시판",
        ),
        elevation: 0.0,
        actions: <Widget>[],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "${rooms.length}개의 게시글",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: rooms == null ? 0 : rooms.length,
                itemBuilder: (BuildContext context, int index) {
                  if (rooms.length != 0) {
                    Map chatroom = rooms[index];
                    print(rooms[index]);
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
                    ImageProvider c;

                    if (chatroom['img'] == 'x') {
                      if (chatroom['bossmbti'] != null)
                        c = Image.asset(
                                'assets/mbti/' + chatroom['bossmbti'] + '.png')
                            .image;
                      else
                        c = Image.asset('assets/person.png').image;
                    } else {
                      c = CachedNetworkImageProvider(
                          'http://$myIP:3001/${chatroom['img']}');
                    }
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: ListTile(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          Map<String, dynamic> isDeny =
                              await apiService.deny_check(chatroom['room_num'],
                                  sharedPreferences.getString('id'));
                          if (isDeny['message']) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('알림'),
                                    content: Text('강퇴된 채팅방입니다.'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('닫기'),
                                      )
                                    ],
                                  );
                                });
                          } else {
                            String roomNumber =
                                sharedPreferences.getString('room_num');
                            if (roomNumber == null)
                              roomNumber = "${chatroom['room_num']}";
                            else
                              roomNumber =
                                  roomNumber + ",${chatroom['room_num']}";
                            sharedPreferences.setString('room_num', roomNumber);

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return ChatPage(chatroom['room_num'],
                                      chatroom['category']);
                                },
                              ),
                            );
                          }
                        },
                        leading: CircleAvatar(radius: 25.0, backgroundImage: c),
                        title: Column(children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                children: [Text("${chatroom['bossname']}")],
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
                                  Text("$start ~ $end ",
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
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: RaisedButton(
          child: Text(
            "게시글 작성하기",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          color: Colors.indigo[300],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Postscreen(
                      widget._img, widget._name, widget._category);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
