import 'package:flutter/material.dart';

import 'package:iamport_flutter/iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

class Certification extends StatelessWidget {
  static const String userCode = 'imp10391932';

  @override
  Widget build(BuildContext context) {
    CertificationData data = ModalRoute.of(context).settings.arguments;
    String phonenum = data.phone;
    String username = data.name;
    print("phone, name : " + data.phone + data.name);

    return IamportCertification(
      appBar: new AppBar(
        title: new Text('본인인증'),
      ),
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/mbti/ALL.png'),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      userCode: userCode,
      data: data,
      callback: (Map<String, String> result) {
        Map<String, String> tmp = {
          'request_id': result['request_id'],
          'imp_uid': result['imp_uid'],
          'success': result['success'],
          'phone': phonenum,
          'name': username
        };
        Navigator.pop(context);
        Navigator.pushReplacementNamed(
          context,
          '/register',
          arguments: tmp,
        );
      },
    );
  }
}
