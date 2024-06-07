import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateChapter extends StatefulWidget {
  const CreateChapter({super.key});

  @override
  State<CreateChapter> createState() => _CreateChapterState();
}

class _CreateChapterState extends State<CreateChapter> {
  
  TextEditingController chapter = TextEditingController();
  
  List chapters = [];

  getChapters() async {
    final url = Uri.parse('http://68.178.163.174:5001/chapter/');

    Response res = await get(url);
    
    setState(() {
      chapters = jsonDecode(res.body);
    });
  }

  addChapter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? course_id = await prefs.getString('course_id');
    final url = Uri.parse('http://68.178.163.174:5001/chapter/add');
    Map data = {'chapter_name': chapter.text, 'course_id': course_id.toString()};

    Response res = await post(url, body: data);

    print(res.statusCode);

    if(res.statusCode == 201){
            Fluttertoast.showToast(
                msg: "Submitted",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0

            );
            getChapters();
    }
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getChapters();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Create Chapter',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            CustomTextField(controller: chapter, hintText: 'Chapter Name', obscureText: false, textinputtypephone: false),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              addChapter();
            }, 
                child: Text('Submit') ),
            
            SizedBox(height: 20,),
            SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name'))
                ],
                rows: [
                  for(var i in chapters)
                    DataRow(cells: [
                      DataCell(Text('${i['id']}')),
                      DataCell(Text('${i['chapter_name']}'))
                    ])
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
