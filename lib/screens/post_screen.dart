import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trafit/screens/ChatPage.dart';
import 'package:trafit/screens/notifications.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

SharedPreferences shared;
var room = 0;
//Directory dir;
Future<SharedPreferences> call() async {
  //dir = await getTemporaryDirectory();
  shared = await SharedPreferences.getInstance();
  return SharedPreferences.getInstance();
}

class Postscreen extends StatefulWidget {
  final String _category;

  Postscreen(this._category);

  @override
  _PostscreenState createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final TextEditingController _commentControl = new TextEditingController();
  Future<SharedPreferences> shared;
  ImageProvider imageProvider;

  int genderCheck = 0;
  String travelMonth = '01';
  String travelDay = '01';
  String startMonth = '01';
  String startDay = '01';
  String endMonth = '01';
  String endDay = '01';

  @override
  void initState() {
    super.initState();
    shared = call();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: shared,
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            print(widget._category);
            return body(snapshot.data);
          } else {
            return Text('');
          }
        });
  }

  Widget body(SharedPreferences shared) {
    ImageProvider c;

    if (shared.getString('img') == 'x') {
      if (shared.getString('mbti') != null)
        c = Image.asset('assets/mbti/' + shared.getString('mbti') + '.png')
            .image;
      else
        c = Image.asset('assets/person.png').image;
    } else {
      c = CachedNetworkImageProvider(
          'http://$myIP:3001/${shared.getString('img')}');
    }
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
          "새 채팅 만들기",
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            TextField(
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: "채팅방을 소개해주세요",
                hintStyle: TextStyle(
                  fontSize: 17.0,
//                    color: Colors.black,
                ),
                prefixIcon: Icon(
                  Icons.edit,
//                    Icons.perm_identity,
                  color: Colors.grey,
                ),
              ),
              maxLines: 10,
              controller: _commentControl,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
                      child: Row(
                        children: [
                          Text("시작    "),
                          DropdownButton<String>(
                            value: startMonth,
                            autofocus: false,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.grey),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                startMonth = newValue;
                              });
                            },
                            items: <String>[
                              '01',
                              '02',
                              '03',
                              '04',
                              '05',
                              '06',
                              '07',
                              '08',
                              '09',
                              '10',
                              '11',
                              '12'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                            child: Text("월 "),
                          ),
                          DropdownButton<String>(
                            value: startDay,
                            autofocus: false,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.grey),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                startDay = newValue;
                              });
                            },
                            items: <String>[
                              '01',
                              '02',
                              '03',
                              '04',
                              '05',
                              '06',
                              '07',
                              '08',
                              '09',
                              '10',
                              '11',
                              '12',
                              '13',
                              '14',
                              '15',
                              '16',
                              '17',
                              '18',
                              '19',
                              '20',
                              '21',
                              '22',
                              '23',
                              '24',
                              '25',
                              '26',
                              '27',
                              '28',
                              '29',
                              '30',
                              '31'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Text("일"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                      child: Row(
                        children: [
                          Text("끝    "),
                          DropdownButton<String>(
                            value: endMonth,
                            autofocus: false,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.grey),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                endMonth = newValue;
                              });
                            },
                            items: <String>[
                              '01',
                              '02',
                              '03',
                              '04',
                              '05',
                              '06',
                              '07',
                              '08',
                              '09',
                              '10',
                              '11',
                              '12'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                            child: Text("월 "),
                          ),
                          DropdownButton<String>(
                            value: endDay,
                            autofocus: false,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.grey),
                            underline: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                endDay = newValue;
                              });
                            },
                            items: <String>[
                              '01',
                              '02',
                              '03',
                              '04',
                              '05',
                              '06',
                              '07',
                              '08',
                              '09',
                              '10',
                              '11',
                              '12',
                              '13',
                              '14',
                              '15',
                              '16',
                              '17',
                              '18',
                              '19',
                              '20',
                              '21',
                              '22',
                              '23',
                              '24',
                              '25',
                              '26',
                              '27',
                              '28',
                              '29',
                              '30',
                              '31'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Text("일"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: FlatButton(
                child: Text(
                  "저장",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: () async {
                  await _addpost(widget._category);
                  String room_num = shared.getString('room_num');
                  shared.setString(
                      'room_num', room_num + ',' + room.toString());
                  print('asdas' + room.toString());
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _addpost(String category) async {
    ApiService apiService = new ApiService();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('id');
    String username = sharedPreferences.getString('username');
    String mbti = sharedPreferences.getString('mbti');
    String img = sharedPreferences.getString('img');
    String _comment = _commentControl.text;
    String date = DateFormat('yy.MM.dd kk:mm').format(DateTime.now());
    String startDate = startMonth + startDay;
    String endDate = endMonth + endDay;
    Map<String, dynamic> response = await apiService.post_room(
        img, id, username, _comment, category, date, mbti, startDate, endDate);
    Fluttertoast.showToast(
      msg: response['message'],
      toastLength: Toast.LENGTH_LONG,
    );
    room = response['room'];
  }
}
