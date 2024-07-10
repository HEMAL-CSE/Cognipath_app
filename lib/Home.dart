import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIndex = 0;
  final PageController controller = PageController();

  List<String> images = [
    "assets/cog3.jfif",
    "assets/cog2.jpg",
    "assets/cog1.jfif",
    "assets/cog4.jfif",
    // "assets/banner4.jpg",

  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // navigateToDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CogniPath', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white,),
              onPressed: () {}),
        ],

        backgroundColor: Color(0xff01013f),
        leading: IconButton(onPressed: (){},
          icon: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white,),
            onPressed: () {} ,
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)
            )
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 14,),
          SizedBox(height: 200,
            width: double.infinity,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index % images.length;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset(
                      images[index % images.length],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < images.length; i++)
                buildIndicator(currentIndex == i)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    controller.jumpToPage(currentIndex - 1);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    controller.jumpToPage(currentIndex + 1);
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () async {
              // Navigator.pushNamed(context, '/addbreedingdata');
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? role = await prefs.getString('role');
              print(role);
              if(role == 'Student'){
                Navigator.pushNamed(context, '/studentDeshboard');
              }else{
                Navigator.pushNamed(context, '/');

              }
            },
            child: Card(
              color: Color(0xff01013f),
              elevation: 5,
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                height: 150,
                width: 150,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Student Login',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),),
                      SizedBox(height: 10,),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Icon(SimpleLineIcons.people, color: Colors.white,)
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 04,),

          GestureDetector(
            onTap: () async {
              // Navigator.pushNamed(context, '/addbreedingdata');
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? role = await prefs.getString('role');
              if(role == 'Teacher'){
                Navigator.pushNamed(context, '/teacherDeshboard');
              }else{
                Navigator.pushNamed(context, '/');

              }
            },
            child: Card(
              color: Color(0xff01013f),
              elevation: 5,
              margin: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                height: 150,
                width: 150,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Teacher Login',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.white),),
                      SizedBox(height: 10,),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Icon(FontAwesome5Solid.chalkboard_teacher, color: Colors.white,)
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 14,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(09.0),
                child: Text('Powered By', style: TextStyle(),),
              ),
              Image.asset('assets/logo.jfif', width: 92),

            ],
          )

        ],

      ),

    );

  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 10,
        width: isSelected ? 12 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}