import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetExam extends StatefulWidget {
  const SetExam({super.key});

  @override
  State<SetExam> createState() => _SetExamState();
}

class _SetExamState extends State<SetExam> {

  TextEditingController exam_name = TextEditingController();




  List questions = [];

  getQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? class_id = prefs.getString('class_id');
    String? teacher_role = prefs.getString('teacher_role');
    String? subject_id = prefs.getString('subject_id');
    String? course_id = prefs.getString('course_id');

    final url = teacher_role == 'Up to HSC' ?  Uri.parse('http://68.178.163.174:5001/questions/school?class_id=${class_id}&subject_id=${subject_id}') : teacher_role == 'Undergraduate' ? Uri.parse('http://68.178.163.174:5001/questions/?course_id=${course_id}') : Uri.parse('http://68.178.163.174:5001/questions');


    Response res = await get(url);

    var resbody = jsonDecode(res.body);

    // print(resbody);

    List result = resbody
        .fold({}, (previousValue, element) {
      Map val = previousValue as Map;
      // print(val);
      var id = element['stem_id'];
      if (!val.containsKey(id)) {
        val[id] = [];
      }
      element.remove('stem_id');
      element['selected'] = false;
      val[id]?.add(element);
      return val;
    })
        .entries
        .map((e) => {e.key: e.value})
        .toList();

    print(result);

    setState(() {
      questions = result;
    });
  }

  addExam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? class_id = prefs.getString('class_id');
    String? teacher_role = prefs.getString('teacher_role');
    String? subject_id = prefs.getString('subject_id');
    String? course_id = prefs.getString('course_id');

    final url = Uri.parse('http://68.178.163.174:5001/exam/school/add');

    Map data = {
      'exam_category': 'blooms',
      'class_id': teacher_role == 'Up to HSC' ? class_id : '0',
      'course_id': teacher_role == 'Undergraduate' ? course_id: '0',
      'subject_id': teacher_role == 'Up to HSC' ? subject_id : '0',
      'exam_name': exam_name.text
    };
    
    Response res = await post(url, body: data);

    var resbody = jsonDecode(res.body);
    
    final url1 = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/add');
    for(var i in questions){
      if(i[i.keys.toList()[0]][0]['selected'] == true){
        Map data1 = {'stem_id': i.keys.toList()[0].toString(), 'exam_id': resbody[0]['id'].toString()};
        Response res = await post(url1, body: data1);
        print(res.statusCode);
      }
    }

    Fluttertoast.showToast(
        msg: "Submitted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0

    );
  }



  @override void initState() {
    // TODO: implement initState
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Set Exam',),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 10,),

            CustomTextField(controller: exam_name, hintText: 'Exam Name', obscureText: false, textinputtypephone: false),

            SizedBox(height: 20,),

            for(var i in questions)
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Ques:  ${questions.indexOf(i) +1}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Spacer(),
                          Checkbox(value: i[i.keys.toList()[0]][0]['selected'], onChanged: (value) {
                            setState(() {
                              i[i.keys.toList()[0]][0]['selected'] = !i[i.keys.toList()[0]][0]['selected'];
                            });
                          })
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(child: Text('${i[i.keys.toList()[0]][0]['stem_desc']}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)),
                        ],
                      ),
                      for(var j in i[i.keys.toList()[0]])
                        Row(
                          children: [
                            SizedBox(width: 10,),
                            Text('${j['ques_point']}.', style: TextStyle(fontWeight: FontWeight.w800),),
                            SizedBox(width: 5,),
                            Flexible(child: Text('${j['ques_desc']}')),
                            SizedBox(width: 5,),
                            Text('[${j['domain']}]'),
                            SizedBox(width: 5,),
                            Text('[${j['marks']}]'),
                            // Text('${}')
                          ],
                        )
                    ],
                  ),
                ),
              ),

            SizedBox(height: 10,),
            ElevatedButton(onPressed: () {
              if(exam_name.text.isEmpty == true){
                Fluttertoast.showToast(
                    msg: "Please give exam name",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0

                );
              }else {
                addExam();

              }
            }, child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
