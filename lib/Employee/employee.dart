import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/WebView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  int currentIndex = 0;
  final PageController controller = PageController();

  List<String> images = [
    "assets/HR1.jpg",
    "assets/HR2.jfif",
    "assets/HR3.jpg",
    // "assets/cog4.jfif",
    // "assets/banner4.jpg",

  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Employers Dashboard',),

        body: CustomScrollView(
          primary: false,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
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
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < images.length; i++)
                        buildIndicator(currentIndex == i)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(07, 0, 07, 0),
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

                ],

              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 28,),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 06,
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
                              Text('Job Sector',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                              SizedBox(height: 10,),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(Entypo.suitcase, color: Colors.white,)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, '/giveExamblooms');
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
                              Text('Job Position', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                              SizedBox(height: 10,),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(Entypo.pencil, color: Colors.white,)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                     // Navigator.pushNamed(context, '/checkmarks');
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
                              Text('Compentancy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white), textAlign: TextAlign.center,),
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
                    onTap: () {
                      //Navigator.pushNamed(context, '/career_path');
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
                              Text('Mapping',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                              SizedBox(height: 10,),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Icon(Icons.join_full_outlined, color: Colors.white,)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
            // SliverToBoxAdapter(
            //   child: SizedBox(height: 150,),
            // ),
            // SliverToBoxAdapter(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(09.0),
            //         child: Text('Powered By', style: TextStyle(),),
            //       ),
            //       Image.asset('assets/logo.jfif', width: 90),
            //
            //     ],
            //   ),
            // )
          ],
        )

    );
  }
}
