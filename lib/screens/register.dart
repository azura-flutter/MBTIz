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
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final TextEditingController _introduceControl = new TextEditingController();
  final TextEditingController _emailcodeControl = new TextEditingController();
  final TextEditingController _ageControl = new TextEditingController();
  TextEditingController _genderControl = new TextEditingController();
  List<int> ageList = [1980];
  int idCheck = 0;
  int genderCheck = 0;
  String dropdownValue_age = '20';
  String dropdownValue_gender = '남';
  int emailauthCheck = 0;
  bool emailCheck = false;
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
                    hintText: "이름",
                    prefixIcon: Icon(
                      Icons.face,
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  maxLines: 1,
                  controller: _usernameControl, //유저이름 컨트롤러
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.mail_outline,
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
                            hintText: "010-0000-0000",
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                          maxLines: 1,
                          controller: _emailControl, //이메일 컨트롤러
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
                              "전송".toUpperCase(),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              String ajouEmail = _emailControl.text;
                              if (ajouEmail.split('@')[1] != 'ajou.ac.kr') {
                                Fluttertoast.showToast(
                                  msg: "학교 이메일을 입력하세요!",
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              } else {
                                emailCheck = true;
                                Fluttertoast.showToast(
                                  msg: "이메일을 확인해주세요",
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              }
                              if (emailCheck) {
                                String abc = await apiService
                                    .emailAuth(_emailControl.text);
                                print(abc);
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.send,
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
                            hintText: "인증번호",
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                          maxLines: 1,
                          controller: _emailcodeControl, //이메일 컨트롤러
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
                              "인증".toUpperCase(),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              String message = await apiService
                                  .emailauthCheck(_emailcodeControl.text);
                              if (message == '인증성공') {
                                emailauthCheck = 1;
                                Fluttertoast.showToast(
                                  msg: "인증이 완료되었습니다.",
                                  toastLength: Toast.LENGTH_LONG,
                                );
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.people,
                            ),
                            SizedBox(width: 15.0),
                            Text(
                              "성별",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            SizedBox(width: 15.0),
                            DropdownButton<String>(
                              value: dropdownValue_gender,
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
                                  dropdownValue_gender = newValue;
                                  if (dropdownValue_gender == '남')
                                    genderCheck = 0;
                                  else
                                    genderCheck = 1;
                                });
                              },
                              items: <String>[
                                '남',
                                '여'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
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
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.swap_vert,
                            ),
                            SizedBox(width: 15.0),
                            Text(
                              "나이",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            SizedBox(width: 15.0),
                            DropdownButton<String>(
                              value: dropdownValue_age,
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
                                  dropdownValue_age = newValue;
                                });
                              },
                              items: <String>[
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
                                '31',
                                '32',
                                '33',
                                '34',
                                '35',
                                '36',
                                '37',
                                '38',
                                '39',
                                '40',
                                '41',
                                '42',
                                '43',
                                '44',
                                '45',
                                '46',
                                '47',
                                '48',
                                '49',
                                '50',
                                '51',
                                '52',
                                '53',
                                '54',
                                '55',
                                '56',
                                '57',
                                '58',
                                '59',
                                '60',
                                '61',
                                '62',
                                '63',
                                '64',
                                '65',
                                '66',
                                '67',
                                '68',
                                '69',
                                '70'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
                    hintText: "자신을 소개해주세요.",
                    prefixIcon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                  maxLines: 1,
                  controller: _introduceControl, //이메일 컨트롤러
                ),
              ),
            ),
            SizedBox(height: 40.0),
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
                      _usernameControl.text,
                      _emailControl.text,
                      _passwordControl.text,
                      genderCheck,
                      int.parse(dropdownValue_age),
                      _introduceControl.text,
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

  void _handleSubmitted(String value) {
    _emailcodeControl.clear();
  }
}
