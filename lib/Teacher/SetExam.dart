import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class SetExam extends StatefulWidget {
  const SetExam({super.key});

  @override
  State<SetExam> createState() => _SetExamState();
}

class _SetExamState extends State<SetExam> {

  String? chapter;
  List chapters = [];
  List questions = [];

  getChapters() async {
    final url = Uri.parse('http://68.178.163.174:5001/chapter/');

    Response res = await get(url);

    setState(() {
      chapters = jsonDecode(res.body);
    });
  }

  getQuestions() async {
    final url = Uri.parse('http://68.178.163.174:5001/questions');

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

    final url = Uri.parse('http://68.178.163.174:5001/exam/add');    
    
    Map data = {'exam_category': 'blooms', 'chapter_id': chapter};
    
    Response res = await post(url, body: data);

    var resbody = jsonDecode(res.body);
    
    final url1 = Uri.parse('http://68.178.163.174:5001/exam/blooms/add');
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
    getChapters();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Set Exam',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomDropdown(value: chapter, data: chapters,hint: 'Chapter Name', onChanged: (value) {
              setState(() {
                chapter = value;
              });
            }, fieldNames: ['chapter_name', 'id']),
            SizedBox(height: 10,),
            // ElevatedButton(onPressed: () {
            //
            // },
            // child: Text('Search')),

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
              addExam();
            }, child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
