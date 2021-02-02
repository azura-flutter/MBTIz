import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trafit/screens/cart.dart';
import 'package:trafit/screens/home.dart';
import 'package:trafit/screens/post_screen.dart';
import 'package:trafit/screens/notifications.dart';
import 'package:trafit/screens/profile.dart';
import 'package:trafit/util/const.dart';
import 'package:trafit/widgets/badge.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/screens/user_in_chat.dart';
import 'package:trafit/screens/search_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  static DateTime currentBackPressTime;

  _isEnd() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      _globalKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text('종료하려면 한 번 더 눌러주세요.'),
        ));
      return false;
    }
    return true;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("종료하시겠습니까?"),
            actions: <Widget>[
              FlatButton(
                child: Text("네"),
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
              ),
              FlatButton(
                child: Text("아니오"),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: <Widget>[
              Home(),
              userInChatScreen(),
              chatSearchScreen(""),
              CartScreen(),
              Profile(),
            ],
          ),
        ),

        // body: PageView(
        //   physics: NeverScrollableScrollPhysics(),
        //   controller: _pageController,
        //   onPageChanged: onPageChanged,
        //   children: <Widget>[
        //     Home(),
        //     userInChatScreen(),
        //     chatSearchScreen(""),
        //     CartScreen(),
        //     Profile(),
        //   ],
        // ),

        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 30.0,
                  ),
                  color: _page == 0
                      ? Theme.of(context).accentColor
                      : Theme.of(context).textTheme.caption.color,
                  onPressed: () => _pageController.jumpToPage(0),
                ),
                IconButton(
                  icon: Icon(
                    Icons.forum,
                    size: 30.0,
                  ),
                  color: _page == 1
                      ? Theme.of(context).accentColor
                      : Theme.of(context).textTheme.caption.color,
                  onPressed: () => _pageController.jumpToPage(1),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                  color: _page == 2
                      ? Theme.of(context).accentColor
                      : Theme.of(context).textTheme.caption.color,
                  onPressed: () => _pageController.jumpToPage(2),
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 30.0,
                  ),
                  color: _page == 4
                      ? Theme.of(context).accentColor
                      : Theme.of(context).textTheme.caption.color,
                  onPressed: () => _pageController.jumpToPage(4),
                ),
              ],
            ),
            color: Theme.of(context).primaryColor,
            //shape: CircularNotchedRectangle(),
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            elevation: 4.0,
            child: Icon(
              Icons.add,
              size: 35.0,
            ),
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    if (sharedPreferences.getString('mbti') == 'ENFJ')
                      return Postscreen('1');
                    else if (sharedPreferences.getString('mbti') == 'ENFP')
                      return Postscreen('2');
                    else if (sharedPreferences.getString('mbti') == 'ENTJ')
                      return Postscreen('3');
                    else if (sharedPreferences.getString('mbti') == 'ENFP')
                      return Postscreen('4');
                    else if (sharedPreferences.getString('mbti') == 'ESFJ')
                      return Postscreen('5');
                    else if (sharedPreferences.getString('mbti') == 'ESFP')
                      return Postscreen('6');
                    else if (sharedPreferences.getString('mbti') == 'ISTP')
                      return Postscreen('7');
                    else if (sharedPreferences.getString('mbti') == 'ISTJ')
                      return Postscreen('8');
                    else if (sharedPreferences.getString('mbti') == 'ISFP')
                      return Postscreen('9');
                    else if (sharedPreferences.getString('mbti') == 'ISFJ')
                      return Postscreen('10');
                    else if (sharedPreferences.getString('mbti') == 'INTJ')
                      return Postscreen('11');
                    else if (sharedPreferences.getString('mbti') == 'INTP')
                      return Postscreen('12');
                    else if (sharedPreferences.getString('mbti') == 'INFP')
                      return Postscreen('13');
                    else if (sharedPreferences.getString('mbti') == 'INFJ')
                      return Postscreen('14');
                    else if (sharedPreferences.getString('mbti') == 'ESTP')
                      return Postscreen('15');
                    else if (sharedPreferences.getString('mbti') == 'ESTJ')
                      return Postscreen('16');

                    return Postscreen('17');
                  },
                ),
              );
            }), //검색 아이콘(center)
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    firebaseCloudMessaging_Listeners();
    _firebaseMessaging.configure(
      // 앱이 실행중일 경우
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print('token:' + token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
