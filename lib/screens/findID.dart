import 'package:flutter/material.dart';
import 'package:trafit/util/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

ApiService apiService = new ApiService();

class FindIDScreen extends StatefulWidget {
  @override
  _FindIDScreenState createState() => _FindIDScreenState();
}

class _FindIDScreenState extends State<FindIDScreen> {
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _emailcodeControl = new TextEditingController();

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
      body: Container(
        margin: EdgeInsets.only(top: 0, bottom: 50, left: 20.0, right: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '본인확인을 위한 휴대전화 인증이 필요합니다.',
//                  "${Constants.appName}",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.caption.color,
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
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.face,
                        color: Colors.black,
                      ),
                    ),
                    maxLines: 1,
                    //controller: _useridControl,
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
              SizedBox(height: 50.0),
              Container(
                height: 40.0,
                child: RaisedButton(
                  child: Text(
                    "아이디 찾기".toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    // Map<String, dynamic> response = await apiService.login(
                    //    _useridControl.text, _passwordControl.text);

                    // Fluttertoast.showToast(
                    //   msg: response['message'],
                    //   toastLength: Toast.LENGTH_LONG,
                    // );

                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) {
                    //       return LoginScreen();
                    //     },
                    //   ),
                    // );
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
