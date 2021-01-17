import 'package:flutter/material.dart';
import 'package:trafit/screens/login.dart';
import 'package:trafit/screens/register.dart';
import 'package:flutter/services.dart';

class JoinApp extends StatefulWidget {
  @override
  _JoinAppState createState() => _JoinAppState();
}

class _JoinAppState extends State<JoinApp> with SingleTickerProviderStateMixin {
  // TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(vsync: this, initialIndex: 1, length: 2);
  //   SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  // }
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
        //   bottom: TabBar(
        //     controller: _tabController,
        //     indicatorColor: Theme.of(context).accentColor,
        //     labelColor: Theme.of(context).accentColor,
        //     unselectedLabelColor: Colors.grey,
        //     labelStyle: TextStyle(
        //       fontSize: 20.0,
        //       fontWeight: FontWeight.w800,
        //     ),
        //     unselectedLabelStyle: TextStyle(
        //       fontSize: 20.0,
        //       fontWeight: FontWeight.w800,
        //     ),
        //     tabs: <Widget>[
        //       Tab(
        //         text: "회원가입",
        //       ),
        //       Tab(
        //         text: "로그인",
        //       ),
        //     ],
        //   ),
        // ),

        // body: TabBarView(
        //   controller: _tabController,
        //   children: <Widget>[
        //     RegisterScreen(),
        //     LoginScreen(),

        //   ],
        // ),
        body: Container(
          margin:
              EdgeInsets.only(top: 100, bottom: 50, left: 20.0, right: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/travel.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 50.0),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '환영합니다.\n',
//                  "${Constants.appName}",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '당신을 위한 동행자가',
//                  "${Constants.appName}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '트래핏에서 기다리고 있어요!',
//                  "${Constants.appName}",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                SizedBox(height: 100.0),
                Container(
                  height: 40.0,
                  child: RaisedButton(
                    child: Text(
                      "로그인".toUpperCase(),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    color: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.center,
                  child: FlatButton(
                    child: Text(
                      "가입",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return RegisterScreen();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
