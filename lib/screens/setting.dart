import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trafit/providers/app_provider.dart';
import 'package:trafit/screens/Mbti_ei_screen.dart';
import 'package:trafit/screens/join.dart';
import 'package:trafit/util/api_service.dart';
import 'package:trafit/util/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiService apiService = new ApiService();
SharedPreferences sharedPreferences;
List<String> hits;

Future<List> call() async {
  sharedPreferences = await SharedPreferences.getInstance();
  return apiService.show_comment(sharedPreferences.getString('id'));
}

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "설정",
        ),
        actions: <Widget>[],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Mbti_ei("hello", 0);
                                },
                              ),
                            );
                          },
                          child: Text(
                            "MBTI 검사 다시하기",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 10.0,
                  color: Colors.grey[350],
                  thickness: 0.5,
                ),
                Container(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 10, 10),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          //첫 페이지 위젯으로 이동하면서 연결된 모든 위젯을 트리에서 삭제
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => JoinApp()),
                              (route) => false);
                        },
                        // onTap: () async {
                        //   SharedPreferences sharedPreferences =
                        //       await SharedPreferences.getInstance();
                        //   sharedPreferences.setString('id', null);
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (BuildContext context) {
                        //         return LoginScreen();
                        //       },
                        //     ),
                        //   );
                        // },
                        child: Text(
                          "로그아웃",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
            Divider(
              height: 10.0,
              color: Colors.grey[350],
              thickness: 0.5,
            ),
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? SizedBox()
                : ListTile(
                    title: Text(
                      "다크 테마 적용하기",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Switch(
                      value: Provider.of<AppProvider>(context).theme ==
                              Constants.lightTheme
                          ? false
                          : true,
                      onChanged: (v) async {
                        if (v) {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.darkTheme, "dark");
                        } else {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.lightTheme, "light");
                        }
                      },
                      activeColor: Theme.of(context).accentColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
