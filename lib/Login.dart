import 'dart:convert';
import 'dart:math';


import 'package:cognipath/components/CustomDropdown.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController phone_number = TextEditingController();
  TextEditingController password = TextEditingController();


  bool buttonDisabled = false;



  // final FirebaseAuth auth = FirebaseAuth.instance;

  // void goToDashboard(user_id, token, role) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   await prefs.setString('user_id', user_id.toString());
  //   await prefs.setString('token', token);
  //   await prefs.setString('role', role.toString());
  //
  //   switch (role) {
  //     case 'Receiver':
  //       final url = Uri.parse('http://68.178.163.174:5003/receiver/user_id?id=${user_id}');
  //       Response res = await get(url);
  //       var resbody = jsonDecode(res.body);
  //       await prefs.setString('receiver_id', resbody['id'].toString());
  //       Navigator.pushNamed(context, '/receiverhomepage');
  //       break;
  //     case 'Donor':
  //       final url = Uri.parse('http://68.178.163.174:5003/donor/user_id?id=${user_id}');
  //       Response res = await get(url);
  //       var resbody = jsonDecode(res.body);
  //       await prefs.setString('donor_id', resbody['id'].toString());
  //       Navigator.pushNamed(context, '/donerDeshboard');
  //       break;
  //   }
  //
  // }

  // void verifyUserPhoneNumber() {
  //   setState(() {
  //     buttonDisabled = true;
  //   });
  //   auth.verifyPhoneNumber(
  //     phoneNumber: '+88' + phone_number.text,
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential).then(
  //             (value) => print('Logged In Successfully'),
  //       );
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       print(e.message);
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       receivedID = verificationId;
  //       showOTP = true;
  //       buttonDisabled = false;
  //       setState(() {});
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       print('TimeOut');
  //     },
  //   );
  // }

  // void navigateToDashboard() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? role = prefs.getString('role');
  //   switch (role) {
  //     case 'Receiver':
  //       Navigator.pushNamed(context, '/receiverhomepage');
  //       break;
  //     case 'Donor':
  //       Navigator.pushNamed(context, '/donerDeshboard');
  //       break;
  //   }
  // }


  // Future<void> verifyOTPCode() async {
  //   setState(() {
  //     buttonDisabled = true;
  //   });
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: receivedID,
  //     smsCode: otp.text,
  //   );
  //   await auth
  //       .signInWithCredential(credential)
  //       .then((value) async {
  //     final url = multipleRole == false ?  Uri.parse('http://68.178.163.174:5003/user/login') : Uri.parse('http://68.178.163.174:5003/user/login/${role}');
  //
  //     Map data = {'mobile': phone_number.text};
  //
  //     Response res = await post(url, body: data);
  //
  //     var resbody = jsonDecode(res.body);
  //
  //     if(res.statusCode == 404){
  //       Fluttertoast.showToast(
  //           msg: "${resbody['msg']}",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0
  //
  //       );
  //     }else if(res.statusCode == 300){
  //       setState(() {
  //         multipleRole = true;
  //       });
  //     }
  //
  //     else if (res.statusCode == 201) {
  //       Fluttertoast.showToast(
  //           msg: "${resbody['msg']}",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0
  //
  //       );
  //
  //       goToDashboard(resbody['user_id'], resbody['token'], resbody['role']);
  //
  //     }
  //
  //     if (res.statusCode == 404) {
  //       Fluttertoast .showToast(
  //           msg: "${resbody['msg']}",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0
  //
  //       );
  //     }
  //
  //     setState(() {
  //       buttonDisabled = false;
  //     });
  //   });
  // }

  void login() async {
    final url = Uri.parse('http://68.178.163.174:5001/user/login_with_phone_number');

    Map data = {'phone': phone_number.text, 'password': password.text};

    Response res = await post(url, body: data);

    var resbody = jsonDecode(res.body);

    if (res.statusCode == 403) {
      Fluttertoast.showToast(
          msg: "${resbody['msg']}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0

      );
    }

    if (res.statusCode == 201) {
      if(resbody['role'] != 'Student' && resbody['role'] != 'Teacher'){
        Fluttertoast.showToast(
            msg: "User is not a student or teacher",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0

        );
      }else{
        Fluttertoast.showToast(
            msg: "${resbody['msg']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0

        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', resbody['token']);
        await prefs.setString('role', resbody['role']);
        await prefs.setString('user_id', resbody['user_id'].toString());
        if(resbody['role'] == 'Student'){
          Navigator.pushNamed(context, '/studentDeshboard');
        }
        if(resbody['role'] == 'Teacher'){
          final url = Uri.parse('http://68.178.163.174:5001/teacher/?user_id=${resbody['user_id']}');
          Response res = await get(url);
          var resbody2 = jsonDecode(res.body);
          print(resbody2);
          prefs.setString('course_id', resbody2[0]['course_id'].toString());

          Navigator.pushNamed(context, '/teacherDeshboard');
        }
      }

    }
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    // navigateToDashboard();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                  decoration: BoxDecoration(

                  ),
                ),
              ),

              CustomTextField(controller: phone_number, hintText: 'Phone Number', obscureText: false,
                  textinputtypephone: true) ,

              SizedBox(height: 10,),

                CustomTextField(controller: password, hintText: 'Password', obscureText: true,
                    textinputtypephone: false),



              Container( padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(04),
                child: ElevatedButton(onPressed: buttonDisabled ? null : (){
                login();
                }, child: const Text("Login"),


                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you a new student? then',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    child:  Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () { Navigator.pushNamed(context, '/register'); },
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}