import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/WebView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class StudentDeshboard extends StatefulWidget {
  const StudentDeshboard({super.key});

  @override
  State<StudentDeshboard> createState() => _StudentDeshboardState();
}

class _StudentDeshboardState extends State<StudentDeshboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Student Dashboard',),

        body: CustomScrollView(
          primary: false,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 48,),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 02,
                crossAxisCount: 2,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/addbreedingdata');
                    },
                    child: Card(
                      color: Color(0xff01013f),
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Online Learning',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                              SizedBox(height: 10,),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(Icons.book_online, color: Colors.white,)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/giveExamblooms');
                    },
                    child: Card(
                      color: Color(0xff01013f),
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Give Exam', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                              SizedBox(height: 10,),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(Entypo.pencil)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                       Navigator.pushNamed(context, '/checkmarks');
                    },
                    child: Card(
                      color: Color(0xff01013f),
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Check Marks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                              SizedBox(height: 10,),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(Icons.checklist, color: Colors.white,)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    child: Card(
                      color: Color(0xff01013f),
                      elevation: 5,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Career Path',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                              SizedBox(height: 10,),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(Entypo.graduation_cap, color: Colors.white,)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(09.0),
                        child: Text('Powered By', style: TextStyle(),),
                      ),
                      Image.asset('assets/logo.jfif', width: 90),

                    ],
                  )

                ],
              ),
            )
          ],
        )

    );
  }
}
