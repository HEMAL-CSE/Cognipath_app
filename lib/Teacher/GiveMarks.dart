import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiveMarks extends StatefulWidget {
  const GiveMarks({super.key});

  @override
  State<GiveMarks> createState() => _GiveMarksState();
}

class _GiveMarksState extends State<GiveMarks> {

  String? chapter;
  List chapters = [];
  List questions = [];
  List students = [];


  String? category;
  List categories = [
    {'name':'blooms'}, {'name':'mcq'}
  ];

  getChapters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? course_id = await prefs.getString('course_id');

    final url = Uri.parse('http://68.178.163.174:5001/chapter/?course_id=${course_id}');

    Response res = await get(url);

    setState(() {
      chapters = jsonDecode(res.body);
    });
  }

  getStudents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? course_id = await prefs.getString('course_id');

    final url = Uri.parse('http://68.178.163.174:5001/student/?course_id=${course_id}');

    Response res = await get(url);

    var resbody = jsonDecode(res.body);

    var results = [];

    for(var i in resbody){
      final url = Uri.parse('http://68.178.163.174:5001/exam/${category}/answers?chapter_id=${chapter}');

      Response res = await get(url);
      print(url);

      var resbody = jsonDecode(res.body);
      List result = resbody
          .fold({}, (previousValue, element) {
        Map val = previousValue as Map;
        // print(val);
        var id = element['stem_id'];
        if (!val.containsKey(id)) {
          val[id] = [];
        }
        element.remove('stem_id');
        element['given_marks'] = TextEditingController(text: element['marks'] != null ? element['marks'] : '');
        val[id]?.add(element);
        return val;
      })
          .entries
          .map((e) => {e.key: e.value})
          .toList();
      i['questions'] = result;
      results.add(i);
    }

    setState(() {
      students = results;
    });
  }

  addMarks() async {
    if(category == 'blooms'){
      final url = Uri.parse('http://68.178.163.174:5001/exam/blooms/marks/add');
      // Map data = {'exam_id': };

    }
  }


  // getExam() async {
  //   final url = Uri.parse('http://68.178.163.174:5001/exam/${category}?chapter_id=${chapter}');
  //
  //   Response res = await get(url);
  //   print(url);
  //
  //   var resbody = jsonDecode(res.body);
  //   List result = resbody
  //       .fold({}, (previousValue, element) {
  //     Map val = previousValue as Map;
  //     // print(val);
  //     var id = element['stem_id'];
  //     if (!val.containsKey(id)) {
  //       val[id] = [];
  //     }
  //     element.remove('stem_id');
  //     element['marks'] = TextEditingController();
  //     val[id]?.add(element);
  //     return val;
  //   })
  //       .entries
  //       .map((e) => {e.key: e.value})
  //       .toList();
  //
  //   print(result);
  //
  //   // return result;
  //   setState(() {
  //     questions = result;
  //   });
  // }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getChapters();
    // getStudents();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Give Marks',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomDropdown(value: chapter, data: chapters,hint: 'Chapter Name', onChanged: (value) {
              setState(() {
                chapter = value;
              });
            }, fieldNames: ['chapter_name', 'id']),
            CustomDropdown(value: category, data: categories,hint: 'Select Question Category', onChanged: (value) {
              setState(() {
                category = value;
              });
            }, fieldNames: ['name', 'name']),

            ElevatedButton(onPressed: () {
                getStudents();
            }, child: Text('Search')),

            SizedBox(height: 20,),

            for(var i in students)
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Text('Name: ${i['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      for(var j in i['questions'])
                        Column(
                          children: [
                            Text('Ques:  ${i['questions'].indexOf(j) +1}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Wrap(
                              children: [
                                for(var k in j[j.keys.toList()[0]])
                                  Row(
                                    children: [
                                      SizedBox(width: 10,),
                                      Text('${k['ques_point']}.', style: TextStyle(fontWeight: FontWeight.w800),),
                                      SizedBox(width: 5,),
                                      Container(
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          width: 90,
                                          child: CustomTextField(controller: k['given_marks'], hintText: 'marks', obscureText: false, textinputtypephone: false)),
                                      Text('[${k['ques_marks']}]')
                                    ],
                                  ),
                              ],
                            )

                          ],
                        ),

                    ],
                  ),
                ),
              )

          ],
        ),
      ),
    );
  }
}
