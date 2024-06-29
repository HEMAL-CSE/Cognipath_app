import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckMarks extends StatefulWidget {
  const CheckMarks({super.key});

  @override
  State<CheckMarks> createState() => _CheckMarksState();
}

class _CheckMarksState extends State<CheckMarks> {

  List marks = [];

  getMarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');

    final url = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/answers?student_id=${user_id}');

    Response res = await get(url);

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
      val[id]?.add(element);
      return val;
    })
        .entries
        .map((e) => {e.key: e.value})
        .toList();

    print(result);

    setState(() {
      marks = result;
    });

  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getMarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Check Marks',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith((states) => Colors.yellowAccent),
              border: TableBorder.all(
                width: 2,
              ),
              columns:  <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'SUBJECT',
                      style: TextStyle(fontStyle: FontStyle.italic),),),
                ),

                DataColumn(
                  label: Expanded(
                    child: Text(
                      'QUESTION NUMBER',
                      style: TextStyle(fontStyle: FontStyle.italic),),),
                ),
                DataColumn(
                  label: Expanded(
                    child: Center(
                      child: Text(
                        'QUESTION CATEGORY', style: TextStyle(fontStyle: FontStyle.italic),),
                    ),),
                ),
                DataColumn(
                  label: Expanded(
                    child: Center(
                      child: Text(
                        'QUESTION POINT', style: TextStyle(fontStyle: FontStyle.italic),),
                    ),),
                ),

                DataColumn(
                  label: Expanded(
                    child: Center(
                      child: Text(
                        'TOTAL SCORE', style: TextStyle(fontStyle: FontStyle.italic,),),
                    ),),
                ),
              ],
              rows:  <DataRow>[
                for(var i in marks)
                  for(var j in i[i.keys.toList()[0]])
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('${j['subject_name']}'))),
                    DataCell(Center(child: Text('${marks.indexOf(i) + 1}'))),
                    DataCell(Center(child: Text('Blooms'))),
                    DataCell(Center(child: Text('${j['ques_point']}'))),
                    DataCell(Center(child: Text('${j['marks'] == null ? 'Invalid': j['marks']}'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      )

    );
  }
}
