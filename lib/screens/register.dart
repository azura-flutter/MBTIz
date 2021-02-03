import 'package:flutter/material.dart';
import 'package:trafit/util/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trafit/screens/login.dart';

ApiService apiService = new ApiService();

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _useridControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  List<int> ageList = [1980];
  int idCheck = 0;
  int genderCheck = 0;
  int emailauthCheck = 0;
  bool emailCheck = false;

  String merchantUid; // 주문번호
  String company = '아임포트'; // 회사명 또는 URL
  String carrier = 'SKT'; // 통신사
  String name; // 본인인증 할 이름
  String phone; // 본인인증 할 전화번호
  String minAge = '20'; // 최소 허용 만 나이

  @override
  Widget build(BuildContext context) {
    Map<String, String> result = ModalRoute.of(context).settings.arguments;

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
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.perm_identity,
                      ),
                      SizedBox(width: 15.0),
                      Flexible(
                        child: TextField(
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
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
                            hintText: "아이디",
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                          maxLines: 1,
                          controller: _useridControl, //이메일 컨트롤러
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: RaisedButton(
                            child: Text(
                              "중복 확인".toUpperCase(),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (_useridControl.text == '') {
                                Fluttertoast.showToast(
                                  msg: "아이디를 입력해주세요.",
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              } else {
                                String abc = await apiService.Id_check(
                                    _useridControl.text);
//                            String abc = '중복되지 않음';
                                if (abc == '중복되지 않음') {
                                  idCheck = 0;
                                  Fluttertoast.showToast(
                                    msg: "사용 가능한 아이디입니다.",
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "이미 사용 중인 아이디입니다.",
                                    toastLength: Toast.LENGTH_LONG,
                                  );
                                }
                              }
                            },
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextField(
                  style: TextStyle(
                    fontSize: 15.0,
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
                    hintText: "비밀번호",
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  obscureText: true,
                  maxLines: 1,
                  controller: _passwordControl, //비밀번호 컨트롤러
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Row(children: <Widget>[
                  Icon(
                    Icons.perm_identity,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    result['name'],
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  )
                ]),
              ),
            ),
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.mail_outline,
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        result['phone'],
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              height: 40.0,
              child: RaisedButton(
                child: Text(
                  "회원가입".toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  //중복체크 했고, 인증 완료 되었을 때 가입 가능한 조건문
                  //if (emailauthCheck == 1) {
                  Map<String, dynamic> response = await apiService.register(
                      _useridControl.text,
                      result['name'],
                      result['phone'],
                      _passwordControl.text,
                      0,
                      0,
                      '',
                      null,
                      null,
                      null);
                  Fluttertoast.showToast(
                    msg: response['message'],
                    toastLength: Toast.LENGTH_LONG,
                  );

                  // }

                  //회원가입 정보 User.dart의 user에 저장 후 json 변환
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
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}
