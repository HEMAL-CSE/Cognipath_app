import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateBloomsQuestion extends StatefulWidget {
  const CreateBloomsQuestion({super.key});

  @override
  State<CreateBloomsQuestion> createState() => _CreateBloomsQuestionState();
}

class _CreateBloomsQuestionState extends State<CreateBloomsQuestion> {
  // String? chapter;
  // List chapters = [];
  List blooms = [];
  List questions = [];

  String? bloom;
  TextEditingController question = TextEditingController();
  List questionOptions = [
    {
      'option': 'a',
      'ques': TextEditingController(),
      'blooms': null,
      'marks': TextEditingController(),
      'correct_answer': TextEditingController(),
    }
  ];

   nextChar(String c) {
    return String.fromCharCode(c.codeUnitAt(0) + 1);
  }

  
  getDomains() async {
     final url = Uri.parse('https://text.cognipath.net/questions/cognitive_domains');
     Response res = await get(url);

     setState(() {
       blooms = jsonDecode(res.body);
     });
  }

  getQuestions() async {

     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? class_id = prefs.getString('class_id');
     String? teacher_role = prefs.getString('teacher_role');
     String? subject_id = prefs.getString('subject_id');
     String? course_id = prefs.getString('course_id');

     final url = teacher_role == 'Up to HSC' ?  Uri.parse('https://text.cognipath.net/questions/school?class_id=${class_id}&subject_id=${subject_id}') : teacher_role == 'Undergraduate' ? Uri.parse('https://text.cognipath.net/questions/?course_id=${course_id}') : Uri.parse('https://text.cognipath.net/questions');

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

  addQues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? class_id = prefs.getString('class_id');
    String? teacher_role = prefs.getString('teacher_role');
    String? subject_id = prefs.getString('subject_id');
    String? course_id = prefs.getString('course_id');

     final url = Uri.parse('https://text.cognipath.net/questions/school/add/stem');

     Map data = {
       'stem':question.text,
       'class_id': teacher_role == 'Up to HSC' ? class_id : '0',
       'course_id': teacher_role == 'Undergraduate' ? course_id: '0',
       'subject_id': teacher_role == 'Up to HSC' ? subject_id : '0'
     };

     Response res = await post(url, body: data);

     var resbody = jsonDecode(res.body);
     print(resbody);

     for(var i in questionOptions){
       final url2 = Uri.parse('https://text.cognipath.net/questions/school/add/ques');
       Map data2 = {'marks': i['marks'].text,'description':i['ques'].text,'stem_id': resbody[0]['id'].toString(), 'ques_point': i['option'],  'domain_id': i['blooms'].toString(), };
       Response res2 = await post(url2, body: data2);
       print(res2);

     }

     if(res.statusCode == 200){
             Fluttertoast .showToast(
                 msg: "Submitted",
                 toastLength: Toast.LENGTH_SHORT,
                 gravity: ToastGravity.CENTER,
                 timeInSecForIosWeb: 1,
                 backgroundColor: Colors.green,
                 textColor: Colors.white,
                 fontSize: 16.0

             );
     }
     getQuestions();

  }
  @override void initState() {
    // TODO: implement initState
    super.initState();
    getDomains();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Blooms',),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 10,),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Question',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                )),
            CustomTextField(controller: question, hintText: 'Add Question', obscureText: false, textinputtypephone: false, maxLines: 5,),
            SizedBox(height: 10,),
            for(var i in questionOptions)
              Container(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5,),
                            Text('${i['option']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            SizedBox(width: 0,),
                            Container(width: 300,child: CustomTextField(controller: i['ques'], hintText: 'Question', obscureText: false, textinputtypephone: false)),
                          ],
                        ),

                        SizedBox(height: 10,),

                        Container(width: 300,child: CustomTextField(maxLines: 5, controller: i['correct_answer'], hintText: 'Correct Answer', obscureText: false, textinputtypephone: false)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15,),
                            Container(
                              width: 120,
                              child: CustomDropdown(value: i['blooms'] == null ? null : i['blooms'],hint: 'Select Blooms', data: blooms, onChanged: (value){
                                setState(() {
                                  i['blooms'] = value;
                                });
                              }, fieldNames: ['domain', 'id']),
                            ),
                            SizedBox(width: 10,),
                            Container(width: 100,child: CustomTextField(controller: i['marks'], hintText: 'marks', obscureText: false, textinputtypephone: false)),
                          ],

                        ),

                      ],
                    ),
                    SizedBox(width: 25,),
                    if(questionOptions.indexOf(i) != 0)
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            questionOptions.remove(i);

                          });
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              color: Colors.grey
                            ),
                            child: Icon(CupertinoIcons.xmark, color: Colors.redAccent,)),
                      )
                  ],
                ),
              ),

            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    questionOptions.add({'option': '${nextChar('${questionOptions.last['option']}')}', 'ques': TextEditingController(), 'blooms': null, 'marks': TextEditingController(), 'correct_answer': TextEditingController()});
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Add More'),
                ),
              ),
            ),
              SizedBox(height: 10,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff01013f),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    addQues();
              }, child: Text('Submit', style: TextStyle(fontSize: 15),)),

            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

              ),

              child: Column(
                children: [
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
                            Text('Ques:  ${questions.indexOf(i) +1}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                              ),

                          ],
                        ),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
