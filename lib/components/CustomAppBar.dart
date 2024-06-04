import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:cognipath/pages/Login.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final title;

  @override
  Size get preferredSize => const Size.fromHeight(50);


  const CustomAppBar({super.key, this.title});


  @override
  Widget build(BuildContext context) {

    // void logout()async {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.remove('role');
    //   prefs.remove('user_id');
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    // }

    return AppBar(
      backgroundColor: Color(0xff01013f),
      title: Text('${this.title}', style: TextStyle(color: Colors.white),),
      centerTitle: true,
      leading: GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back, color: Colors.white,),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // logout();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.logout, color: Colors.white,),
          ),
        )
      ],
    );
  }
}
