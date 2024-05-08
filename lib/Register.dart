import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
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
  TextEditingController village = TextEditingController();
  TextEditingController location = TextEditingController();

  bool buttonDisabled = false;

  List<dynamic> divisions = [];

  String? selectedDivision;

  List<dynamic> districts = [];

  String? selectedDistrict;

  DateTime? lastDonatedDate = null;



  List<dynamic> upazilas = [];

  String? selectedUpazila;
  String? blood_group;

  List blood_groups = [];

  List roles = [
    {'name': 'Donor'},
    {'name': 'Receiver'},
  ];

  String? role;


  TextEditingController phone_number = TextEditingController();
  TextEditingController otp = TextEditingController();

  bool showOTP = false;
  var receivedID = '';


   // final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController search = TextEditingController();

  Map searchedOptions = {};


   // late GoogleMapController mapController;

  // late GoogleMapController minimapController;


  // LatLng? _currentPosition;

  bool _isLoading = true;

  // Set<Marker> markers = {};
  // Set<Marker> minimarkers = {};


  void searchPlaces(search, setState) async {
    final url = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=AIzaSyCUCHfupf6ppvDa6d1o8H19K4xvLPQ2lls');
    Response res = await get(url);

    var resbody = jsonDecode(res.body);
    // print(resbody);

    setState(() {
      searchedOptions = resbody;
    });
  }

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


  void verifyUserPhoneNumber() async {
    setState(() {
      buttonDisabled = true;
    });
    Response res = await get(Uri.parse('http://68.178.163.174:5003/user/check_phone_number?phone_number=${phone_number.text}&role=${role}'));
    if(res.statusCode == 201){
      var json = jsonDecode(res.body);
      if(json['checked'] == 0){
        Fluttertoast.showToast(
            msg: "User already exists",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0

        );
    //   }else if(json['checked'] == 1){
    //     auth.verifyPhoneNumber(
    //       phoneNumber: '+88' + phone_number.text,
    //       verificationCompleted: (PhoneAuthCredential credential) async {
    //         await auth.signInWithCredential(credential).then(
    //               (value) => print('Logged In Successfully'),
    //         );
    //       },
    //
    //       verificationFailed: (FirebaseAuthException e) {
    //         print(e.message);
    //       },
    //       codeSent: (String verificationId, int? resendToken) async {
    //
    //         receivedID = verificationId;
    //         showOTP = true;
    //         buttonDisabled = false;
    //         setState(() {});
    //       },
    //       codeAutoRetrievalTimeout: (String verificationId) {
    //         print('TimeOut');
    //       },
    //     );
    //   }
    }


  }

  // void donorRegister(user_id) async {
  //   final url = Uri.parse('http://68.178.163.174:5003/donor/add');
  //
  //   var x = markers.elementAt(0);
  //   var lat = x.position.latitude;
  //   var lang = x.position.longitude;
  //
  //   Map data = {'user_id': user_id.toString(), 'blood_group_id': blood_group.toString(),'lat': lat.toString(), 'lang': lang.toString(), 'last_donated_date': lastDonatedDate != null ? lastDonatedDate?.toIso8601String() : ''};
  //
  //   Response res = await post(url, body: data);
  //
  //   var resbody = jsonDecode(res.body);
  // }

  void receiverRegister(user_id) async {
    final url = Uri.parse('http://68.178.163.174:5003/receiver/add');

    Map data = {'user_id': user_id.toString()};

    Response res = await post(url, body: data);

    var resbody = jsonDecode(res.body);
  }


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
  //     final url = Uri.parse('http://68.178.163.174:5003/user/register');
  //
  //     Map data = {'name': name.text, 'mobile': phone_number.text, 'role': role.toString(), 'division': selectedDivision.toString(), 'district': selectedDistrict.toString(), 'upazila': selectedUpazila.toString(), 'village': village.text};
  //
  //     Response res = await post(url, body: data);
  //
  //     var resbody = jsonDecode(res.body);
  //
  //     if (res.statusCode == 201) {
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
  //       if(role == 'Donor'){
  //         print('hello donor');
  //         donorRegister(resbody['user_id']);
  //       }
  //       else if(role == 'Receiver'){
  //         receiverRegister(resbody['user_id']);
  //       }
  //       Navigator.pushNamed(context, '/login');
  //     }
  //
  //     if (res.statusCode == 403) {
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
  //     }
  //
  //     setState(() {
  //       buttonDisabled = false;
  //     });
  //   });
  // }

  void getBloodGroups() async {
    final url = Uri.parse('http://68.178.163.174:5003/blood_groups');

    Response res = await get(url);

    setState(() {
      blood_groups = jsonDecode(res.body);
    });
  }

  Future<void> getDivisions() async {
    final String response = await rootBundle.loadString('assets/divisions.json');
    final data = await jsonDecode(response);
    print(data);

    setState(() {
      divisions = data;
    });
  }

  Future<void> getUpazilas(id) async {
    upazilas.clear();
    final String response = await rootBundle.loadString('assets/upazilas.json');
    final data = await jsonDecode(response);
    print(data);
    for(var i in data){
      if(i['district_id'] == id){
        setState(() {
          upazilas.add(i);
        });
      }
    }

  }

  Future<void> getDistricts(id) async {
    districts.clear();
    final String response = await rootBundle.loadString('assets/districts.json');
    final data = await jsonDecode(response);
    print(data);
    for(var i in data){
      if(i['division_id'] == id){
        setState(() {
          districts.add(i);
        });
      }
    }

  }

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


  // @override void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getBloodGroups();
  //   getDivisions();
  //   getLocation();
  // }

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
                  value: role,
                  data: roles,
                  hint: 'Select',
                  onChanged: (value) {

                    setState(() {
                      role = value;
                    });
                  },
                  fieldNames: ['name', 'name']),

              CustomTextField(controller: name, hintText: 'Name', obscureText: false,
                  textinputtypephone: false),

              SizedBox(height: 10,),

              CustomDropdown(
                  value: selectedDivision,
                  data: divisions,
                  hint: 'Select Division',
                  onChanged: (value) {
                    selectedDistrict = null;
                    getDistricts(value);
                    setState(() {
                      selectedDivision = value;
                    });
                  },
                  fieldNames: ['bn_name', 'id']),

              CustomDropdown(
                  value: selectedDistrict,
                  data: districts,
                  hint: 'Select District',
                  onChanged: (value) {
                    selectedUpazila = null;
                    getUpazilas(value);
                    setState(() {
                      selectedDistrict = value;
                    });
                  },
                  fieldNames: ['bn_name', 'id']),


              CustomDropdown(
                  value: selectedUpazila,
                  data: upazilas,
                  hint: 'Select Upazila',
                  onChanged: (value) {

                    setState(() {
                      selectedUpazila = value;
                    });
                  },
                  fieldNames: ['bn_name', 'id']),

              CustomTextField(controller: village, hintText: 'Village', obscureText: false,
                  textinputtypephone: false),

              SizedBox(height: 10,),

              if(role == 'Donor')
                Column(
                  children: [
                    CustomDropdown(
                        value: blood_group,
                        data: blood_groups,
                        hint: 'Select Blood Group',
                        onChanged: (value) {

                          setState(() {
                            blood_group = value;
                          });
                        },
                        fieldNames: ['group', 'id']),

                    CustomDatePicker(date: lastDonatedDate, selectDate: () {
                      _selectDate(context, setState, lastDonatedDate, (value) { lastDonatedDate = value; });
                    }, title: 'Last Donated Date: '),

                    SizedBox(height: 10,),

                    GestureDetector(
                      onTap: () {

                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel:
                            MaterialLocalizations.of(context).modalBarrierDismissLabel,
                            barrierColor: Colors.black45,
                            transitionDuration: const Duration(milliseconds: 200),
                            pageBuilder: (BuildContext buildContext, Animation animation,
                                Animation secondaryAnimation) {
                              return StatefulBuilder(
                                builder: (context, setStateSB) {
                                  return   Stack(
                                    children: [
                                      // GoogleMap(
                                      //   onTap: (latlang) {
                                      //     // _onAddMarkerButtonPressed(latlang);
                                      //     // var x = markers.map((e) => e.markerId == 'mark' ? Marker(markerId: MarkerId('mark'), position: latlang) : e).toSet();
                                      //     var x = markers;
                                      //     x.remove(x.elementAt(0));
                                      //     x.add(Marker(markerId: MarkerId('mark'), position: latlang));
                                      //     setStateSB(() {
                                      //       // markers.add(Marker(markerId: MarkerId('mark'), position: latlang));
                                      //       markers = x;
                                      //     });
                                      //   },
                                      //   initialCameraPosition: CameraPosition(
                                      //     target: _currentPosition!, // San Francisco coordinates
                                      //     zoom: 12,
                                      //   ),
                                      //   onCameraMove: (latlang) {
                                      //     setStateSB(() {
                                      //       _currentPosition = LatLng(latlang.target.latitude, latlang.target.longitude);
                                      //     });
                                      //   },
                                      //
                                      //   markers: markers,
                                      //   onMapCreated: (GoogleMapController controller) {
                                      //     // mapController.dispose();
                                      //     // if(!_controller.isCompleted){
                                      //     //   _controller.complete(controller);
                                      //     //
                                      //     // }
                                      //
                                      //     mapController = controller;
                                      //
                                      //   },
                                      //
                                      // ),

                                      // if (searchedOptions.isNotEmpty &&
                                      //     searchedOptions['predictions'].length != 0)
                                      //   Container(
                                      //       margin: EdgeInsets.symmetric(vertical: 48),
                                      //       height: 300.0,
                                      //       width: double.infinity,
                                      //       decoration: BoxDecoration(
                                      //           color: Colors.black.withOpacity(.6),
                                      //           backgroundBlendMode: BlendMode.darken)),



                                      Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 48, 0, 0),
                                            alignment: Alignment.topCenter,
                                            child: Material(
                                                color: Colors.transparent,
                                                child: CustomTextField(
                                                    controller: search,
                                                    hintText: 'Search',
                                                    obscureText: false,
                                                    onChanged: (value) {
                                                      searchPlaces(value, setStateSB);
                                                    },
                                                    textinputtypephone: false)
                                            ),
                                          ),
                                          if (searchedOptions.isNotEmpty &&
                                              searchedOptions['predictions'].length != 0)
                                            Container(
                                                margin: EdgeInsets.symmetric(vertical: 0),
                                                // height: 300.0,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.black.withOpacity(.6),
                                                    backgroundBlendMode: BlendMode.darken),
                                                child: Column(
                                                  crossAxisAlignment:  CrossAxisAlignment.start,
                                                  children: [
                                                    for(var i in searchedOptions['predictions'])
                                                      Material(

                                                        child: InkWell(
                                                          onTap: () {
                                                            // selectPlace(i['place_id'], setStateSB);
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(10.0),
                                                            child: Container(
                                                              child: Text(
                                                                i['description'],
                                                                style: TextStyle(decoration: TextDecoration.none,fontSize: 15,color: Colors.white, backgroundColor: Colors.transparent, ),
                                                              ),
                                                              width: MediaQuery.of(context).size.width,
                                                            ),
                                                          ),
                                                        ),
                                                        color: Colors.transparent,
                                                      )
                                                  ],
                                                )
                                            ),
                                        ],
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.symmetric(vertical: 20),
                                      //   alignment: Alignment.bottomCenter,
                                      //   child: ElevatedButton(
                                      //     onPressed: () {
                                      //       minimapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                      //         target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                                      //         zoom: 12,
                                      //       )));
                                      //       setState(() {
                                      //         minimarkers = markers;
                                      //       });
                                      //       Navigator.pop(context);
                                      //
                                      //     },
                                      //     child: Text('Set Map'),
                                      //     style: ElevatedButton.styleFrom(
                                      //       backgroundColor: Colors.yellowAccent,
                                      //
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  );
                                },
                              );
                            });
                      },
                       child: _currentPosition == null ?
                      CircularProgressIndicator()
                          : Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey
                        ),
                        child: SizedBox(
                          height: 100,
                          width: 300,
                          child: Stack(
                            children: [
                              // if()
                              // GoogleMap(
                              //   initialCameraPosition: CameraPosition(
                              //     target: _currentPosition!, // San Francisco coordinates
                              //     zoom: 12,
                              //   ),
                              //
                              //   markers: markers,
                              //   onMapCreated: (GoogleMapController controller) {
                              //     // mapController.dispose();
                              //     // if(!_controller.isCompleted){
                              //     //   _controller.complete(controller);
                              //     //
                              //     // }
                              //
                              //     minimapController = controller;
                              //
                              //   },
                              //
                              // ),
                              Container(
                                height: 100,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.transparent
                                ),
                              ),
                            ],
                          ),
                        ),),
                    )

                  ],
                ),

              CustomTextField(controller: phone_number, hintText: 'Phone Number', obscureText: false,
                  textinputtypephone: true),

              SizedBox(height: 10,),

              if(showOTP)
                CustomTextField(controller: otp, hintText: 'OTP', obscureText: true,
                    textinputtypephone: true),

              Container( padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(04),
                child: ElevatedButton(onPressed: buttonDisabled ? null : (){
                  if(showOTP){
                    // verifyOTPCode();
                  } else{
                    verifyUserPhoneNumber();
                  }
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
                    onTap: () { Navigator.pushNamed(context, '/login'); },
                  ),
                ],
              )
            ],
          )
      ),
    );
  }
}