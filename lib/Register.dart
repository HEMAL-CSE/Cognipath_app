import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cognipath/components/CustomDatePicker.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:cognipath/components/CustomTextField.dart';
// import 'package:healthcare/pages/GoogleMaps.dart';
import 'package:http/http.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController institute = TextEditingController();


  bool buttonDisabled = false;

  String? cls;


List courses = [];

List classes = [];

String? course;
String? role;

  // List roles = [
  //   {'name': 'Student'},
  //   {'name': 'Teacher'},
  // ];

  // String? role;


  TextEditingController phone_number = TextEditingController();
  TextEditingController otp = TextEditingController();

  bool showOTP = false;
  var receivedID = '';


   // late GoogleMapController mapController;

  // late GoogleMapController minimapController;


  // LatLng? _currentPosition;

  bool _isLoading = true;

  // Set<Marker> markers = {};
  // Set<Marker> minimarkers = {};

  //
  // void searchPlaces(search, setState) async {
  //   final url = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=AIzaSyCUCHfupf6ppvDa6d1o8H19K4xvLPQ2lls');
  //   Response res = await get(url);
  //
  //   var resbody = jsonDecode(res.body);
  //   // print(resbody);
  //
  //   setState(() {
  //     searchedOptions = resbody;
  //   });
  // }

  // void selectPlace(placeId, setState) async {
  //   final url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyCUCHfupf6ppvDa6d1o8H19K4xvLPQ2lls');
  //
  //   Response res = await get(url);
  //
  //   var resbody = jsonDecode(res.body);
  //
  //   print(resbody);
  //
  //   moveCamera(resbody['result']['geometry']['location']['lat'], resbody['result']['geometry']['location']['lng']);
  //   var x = markers;
  //   x.remove(x.elementAt(0));
  //   var latlang = LatLng(resbody['result']['geometry']['location']['lat'], resbody['result']['geometry']['location']['lng']);
  //   x.add(Marker(markerId: MarkerId('mark'), position: latlang));
  //
  //   setState(() {
  //     search.text = '';
  //     searchedOptions = {};
  //     markers = x;
  //   });
  // }

  // Future<void> moveCamera(lat, lng) async {
  //   // final GoogleMapController controller = await _controller.future;
  //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(lat, lng),
  //     zoom: 12,
  //   )));
  //
  //   setState(() {
  //     _currentPosition = LatLng(lat, lng);
  //   });
  // }

  // void getLocation() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.requestPermission();
  //
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   double lat = position.latitude;
  //   double long = position.longitude;
  //
  //   LatLng location = LatLng(lat, long);
  //
  //
  //   setState(() {
  //     _currentPosition = location;
  //     _isLoading = false;
  //     markers.add(Marker(icon: BitmapDescriptor.defaultMarker,
  //         markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));
  //
  //   });
  // }

  void studentRegister(user_id) async {
    final url = Uri.parse('http://68.178.163.174:5001/student/add');

    Map data = {'user_id': user_id.toString(), 'course_id': course, 'class_id': cls, 'institute': institute.text, 'role': role};

    Response res = await post(url, body: jsonEncode(data), headers: {
      "Content-Type": "application/json; charset=utf-8",
    },);

  }

  void getClasses() async {
    final url = Uri.parse('http://68.178.163.174:5001/class');

    Response res = await get(url);

    setState(() {
      classes = jsonDecode(res.body);
    });


  }
  // void teacherRegister(user_id) async //   final url = Uri.parse('http://68.178.163.174:5001/teacher/add');
  //
  //   Map data = {'user_id': user_id.toString(), 'institute': institute.text};
  //
  //   Response res = await post(url, body: data);
  //
  // }


  // void verifyUserPhoneNumber() async {
  //   setState(() {
  //     buttonDisabled = true;
  //   });
  //
  //   try{
  //     Response res = await get(Uri.parse(
  //         'http://68.178.163.174:5001/user/check_phone_number?phone_number=${phone_number.text}'));
  //     if (res.statusCode == 201) {
  //       var json = jsonDecode(res.body);
  //       if (json['checked'] == 0) {
  //         Fluttertoast.showToast(
  //             msg: "User already exists",
  //             toastLength: Toast.LENGTH_SHORT,
  //             gravity: ToastGravity.CENTER,
  //             timeInSecForIosWeb: 1,
  //             backgroundColor: Colors.green,
  //             textColor: Colors.white,
  //             fontSize: 16.0);
  //       } else if (json['checked'] == 1) {
  //         auth.verifyPhoneNumber(
  //           phoneNumber: '+88' + phone_number.text,
  //           verificationCompleted: (PhoneAuthCredential credential) async {
  //             await auth.signInWithCredential(credential).then(
  //                   (value) => print('Logged In Successfully'),
  //                 );
  //           },
  //           verificationFailed: (FirebaseAuthException e) {
  //             print(e.message);
  //           },
  //           codeSent: (String verificationId, int? resendToken) async {
  //             receivedID = verificationId;
  //             showOTP = true;
  //             buttonDisabled = false;
  //             setState(() {});
  //           },
  //           codeAutoRetrievalTimeout: (String verificationId) {
  //             print('TimeOut');
  //           },
  //         );
  //       }
  //       setState(() {
  //         buttonDisabled = false;
  //       });
  //     }
  //   }catch(err) {
  //     Fluttertoast.showToast(
  //         msg: "${err}",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //     setState(() {
  //       buttonDisabled = false;
  //     });
  //   }
  // }

  void getCourses() async {
    final url = Uri.parse('http://68.178.163.174:5001/course');

    Response res = await get(url);


    setState(() {
      courses = jsonDecode(res.body);
    });
  }




  Future<void> sigup() async {
    setState(() {
      buttonDisabled = true;
    });


      final url = Uri.parse('http://68.178.163.174:5001/user/register');

  Map data = {'name': name.text, 'email': email.text, 'mobile': phone_number.text, 'password': password.text, 'role': 'Student'};

      Response res = await post(url, body: data);

      var resbody = jsonDecode(res.body);

      if (res.statusCode == 201) {
        Fluttertoast.showToast(
            msg: "${resbody['msg']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0

        );
          studentRegister(resbody['user_id']);
        Navigator.pushNamed(context, '/');
      }

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

      setState(() {
        buttonDisabled = false;
      });

  }



  // Future<void> getDivisions() async {
  //   final String response = await rootBundle.loadString('assets/divisions.json');
  //   final data = await jsonDecode(response);
  //   print(data);
  //
  //   setState(() {
  //     divisions = data;
  //   });
  // }
  //
  // Future<void> getUpazilas(id) async {
  //   upazilas.clear();
  //   final String response = await rootBundle.loadString('assets/upazilas.json');
  //   final data = await jsonDecode(response);
  //   print(data);
  //   for(var i in data){
  //     if(i['district_id'] == id){
  //       setState(() {
  //         upazilas.add(i);
  //       });
  //     }
  //   }
  //
  // }
  //
  // Future<void> getDistricts(id) async {
  //   districts.clear();
  //   final String response = await rootBundle.loadString('assets/districts.json');
  //   final data = await jsonDecode(response);
  //   print(data);
  //   for(var i in data){
  //     if(i['division_id'] == id){
  //       setState(() {
  //         districts.add(i);
  //       });
  //     }
  //   }
  //
  // }

  Future<void> _selectDate(BuildContext context,setState, selectedDate, void setSelectedDate(value)) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        setSelectedDate(picked);
      });
    }
  }


  @override void initState() {
    // TODO: implement initState
    super.initState();
    getCourses();
    getClasses();
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
                  child: Text('Register', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                  decoration: BoxDecoration(

                  ),
                ),
              ),
              CustomDropdown(
                  hint: 'Role',
                  value: role, data: [
                {
                  'name': 'Up to HSC'
                },
                {
                  'name': 'Undergraduate'
                },
                {
                  'name': 'Professional'
                }
              ], onChanged: (value) {
                setState(() {
                  role = value;
                });
              }, fieldNames: ['name', 'name']),

              if(role == 'Up to HSC')
              Column(
                children: [
                  CustomDropdown(
                      hint: 'Class Name',
                      value: cls, data: classes, onChanged: (value) {
                    setState(() {
                      cls = value;
                    });
                  }, fieldNames: ['class_name', 'id']),

                  CustomTextField(controller: institute, hintText: 'Institute Name', obscureText: false,
                      textinputtypephone: false),
                  SizedBox(height: 10,),
                ],
              ),

              // SizedBox(height: 20,),

              CustomTextField(controller: name, hintText: 'Name', obscureText: false,
                  textinputtypephone: false),

              SizedBox(height: 10,),


              CustomTextField(controller: email, hintText: 'Email', obscureText: false,
                  textinputtypephone: false),

              SizedBox(height: 10,),

              CustomTextField(controller: password, hintText: 'Password', obscureText: true,
                  textinputtypephone: false),



              SizedBox(height: 10,),

                // CustomDropdown(
                //   hint: 'Select Course',
                //     value: course,
                //     data: courses, onChanged: (value) {
                //   setState(() {
                //     course = value;
                //   });
                // }, fieldNames: ['name', 'id']),
                // SizedBox(height: 10,),



              CustomTextField(controller: phone_number, hintText: 'Phone Number', obscureText: false,
                  textinputtypephone: true),

              SizedBox(height: 10,),

              // if(showOTP)
              //   CustomTextField(controller: otp, hintText: 'OTP', obscureText: true,
              //       textinputtypephone: true),

              Container( padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(04),
                child: ElevatedButton(onPressed: buttonDisabled ? null : (){
                  sigup();
                }, child: const Text("Sign Up")),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Registered? then',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    child:  Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () { Navigator.pushNamed(context, '/'); },
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}