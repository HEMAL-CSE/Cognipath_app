import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiveExamBlooms extends StatefulWidget {
  const GiveExamBlooms({super.key});

  @override
  State<GiveExamBlooms> createState() => _GiveExamBloomsState();
}

class _GiveExamBloomsState extends State<GiveExamBlooms> {
  List subjects = [];
  String? subject;
  List questions = [];
  var existingAnswers = {};

  getSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? class_id = await prefs.getString('class_id');

    final url = Uri.parse('http://68.178.163.174:5001/class/subject?class_id=${class_id}');

    Response res = await get(url);

    setState(() {
      subjects = jsonDecode(res.body);
    });
  }

  getQuestions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    String? class_id = prefs.getString('class_id');
    String? student_role = prefs.getString('student_role');
    String? course_id = prefs.getString('course_id');

    var courseorclassid = student_role == 'Up to HSC' ? 'subject_id=${subject}' : student_role == 'Undergraduate' ? 'course_id=${course_id}' : '';

  print(courseorclassid);

    final url = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/?${courseorclassid}');

      Response res = await get(url);
      print(url);

      var existingResult = {};

      var resbody = jsonDecode(res.body);

      for(var i in resbody){
        final url2 = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/answers?${courseorclassid}&student_id=${user_id}&ques_id=${i['ques_id']}&exam_id=${i['exam_id']}');
        Response res = await get(url2);
        print(jsonDecode(res.body));
        var resbody2 = jsonDecode(res.body);
        print(url2);
        if(resbody2.length > 0){
          for(var k in resbody2){
            existingResult[k['ques_id']] = {'answer_id': k['answer_id'], 'answer':k['answer']};

          }

        }
      }

      print(resbody);
      List result = resbody
          .fold({}, (previousValue, element)  {
        Map val = previousValue as Map;
        // print(val);
        var id = element['stem_id'];
        if (!val.containsKey(id)) {
          val[id] = [];
        }
        element.remove('stem_id');

        element['answer'] = TextEditingController(text: existingResult.containsKey(element['ques_id']) == true ? existingResult[element['ques_id']]['answer'] : '');
        val[id]?.add(element);
        return val;
      })
          .entries
          .map((e) => {e.key: e.value})
          .toList();

    setState(() {
      questions = result;
      existingAnswers = existingResult;
    });
  }

  addAnswers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    final url = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/answers/add');

    for(var i in questions){
      for(var j in i[i.keys.toList()[0]]){
        if(j['answer'].text != '' && existingAnswers.containsKey(j['ques_id']) == false){
          Map data = {'exam_id': j['exam_id'].toString(), 'ques_id': j['ques_id'].toString(), 'student_id': user_id.toString(), 'answer': j['answer'].text};
          Response res = await post(url, body: data);
          print(res.statusCode);
        }else if(j['answer'].text != '' && existingAnswers.containsKey(j['ques_id']) == true){
          final url = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/answers/update?id=${existingAnswers[j['ques_id']]['answer_id']}');
          Map data = { 'answer': j['answer'].text};
          Response res = await put(url, body: data);
          print(res.statusCode);
        }
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubjects();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Blooms',
      ),
      body: ListView(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Chapter Wise Question based on Blooms:',
              style: TextStyle(
                color: Colors.purpleAccent[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          CustomDropdown(value: subject, data: subjects,hint: 'Subject Name', onChanged: (value) {
            setState(() {
              subject = value;
            });
          }, fieldNames: ['name', 'id']),

          SizedBox(height: 10,),
          ElevatedButton(onPressed: () {
              getQuestions();
          }, child: Text('Search')),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                for(var i in questions)
                Card(

                  elevation: 5,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          '${i[i.keys.toList()[0]][0]['stem_desc']}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for(var j in i[i.keys.toList()[0]])
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '${j['ques_point']}) ${j['ques_desc']} [${j['domain']}] [${j['ques_marks']}].',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              CustomTextField(controller: j['answer'], hintText: 'Answer the Question:', obscureText: false, textinputtypephone: false, maxLines: 5,),

                            ],
                          ),

                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                ElevatedButton(onPressed: (){
                    addAnswers();
                }, child: Text('Submit'))

              ],
            ),
          )
        ],
      ),
    );
  }
}
