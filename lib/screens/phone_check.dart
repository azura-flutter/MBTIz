import 'package:flutter/material.dart';
import 'package:trafit/util/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iamport_flutter/model/certification_data.dart';

ApiService apiService = new ApiService();

class PhoneCheck extends StatefulWidget {
  @override
  _PhoneCheckState createState() => _PhoneCheckState();
}

class _PhoneCheckState extends State<PhoneCheck> {
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _usernameControl = new TextEditingController();

  int emailauthCheck = 0;
  bool emailCheck = false;

  final _formKey = GlobalKey<FormState>();
  String merchantUid; // 주문번호
  String company = '아임포트'; // 회사명 또는 URL
  String carrier; // 통신사
  String name; // 본인인증 할 이름
  String phone; // 본인인증 할 전화번호
  String minAge = '20'; // 최소 허용 만 나이

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
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              alignment: Alignment.center,
              child: Text(
                '본인인증을 진행합니다.',
//                  "${Constants.appName}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
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
                          keyboardType: TextInputType.number,
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
                        width: 80,
                        height: 30,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: RaisedButton(
                            child: Text(
                              "인증".toUpperCase(),
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              Map<String, dynamic> noexisted = await apiService
                                  .check_phoneNumber(_emailControl.text);

                              if (_emailControl.text == '' ||
                                  _usernameControl.text == '') {
                                Fluttertoast.showToast(
                                  msg: "이름과 휴대전화를 모두 입력해주세요.",
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              } else if (!noexisted['flag']) {
                                //false이면 중복이다.
                                Fluttertoast.showToast(
                                  msg: "중복된 번호입니다.",
                                  toastLength: Toast.LENGTH_LONG,
                                );
                              } else {
                                CertificationData data =
                                    CertificationData.fromJson({
                                  'merchantUid': merchantUid,
                                  'carrier': carrier,
                                });
                                if (company != null) {
                                  data.company = company;
                                }
                                data.name = _usernameControl.text;
                                data.phone = _emailControl.text;

                                if (minAge.length != null &&
                                    minAge.length > 0) {
                                  data.minAge = int.parse(minAge);
                                }

                                Navigator.pushNamed(context, '/certification',
                                    arguments: data);
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
          ],
        ),
      ),
    );
  }
}
