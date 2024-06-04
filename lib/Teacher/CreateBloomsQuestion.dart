import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateBloomsQuestion extends StatefulWidget {
  const CreateBloomsQuestion({super.key});

  @override
  State<CreateBloomsQuestion> createState() => _CreateBloomsQuestionState();
}

class _CreateBloomsQuestionState extends State<CreateBloomsQuestion> {
  String? chapter;
  List chapters = [];
  List blooms = [
    {'name':'Understanding'},
    {'name':'Remembering'},
    {'name':'Applying'},
    {'name':'Analyzing'},
    {'name':'Evaluating'},
    {'name':'Creating'}
  ];

  String? bloom;
  TextEditingController question = TextEditingController();
  List questionOptions = [
    {
      'option': 'a',
      'ques': TextEditingController(),
      'blooms': null,
    }
  ];

   nextChar(String c) {
    return String.fromCharCode(c.codeUnitAt(0) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Blooms',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomDropdown(value: chapter, data: chapters,hint: 'Chapter Name', onChanged: (value) {
              setState(() {
                chapter = value;
              });
            }, fieldNames: ['chapter_name', 'id']),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('${i['option']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(width: 4,),
                    Container(width: 210,child: CustomTextField(controller: i['ques'], hintText: '', obscureText: false, textinputtypephone: false)),
                    SizedBox(width: 5,),
                    Container(
                      width: 150,
                      child: CustomDropdown(value: i['blooms'] == null ? null : i['blooms'],hint: 'Select Blooms', data: blooms, onChanged: (value){
                        setState(() {
                          i['blooms'] = value;
                        });
                          }, fieldNames: ['name', 'name']),
                    )
                  ],
                ),
              ),

            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    questionOptions.add({'option': '${nextChar('${questionOptions.last['option']}')}', 'ques': TextEditingController(), 'blooms': null});
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
              ElevatedButton(onPressed: () {

              }, child: Text('Submit')),

            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),

              ),
            )
          ],
        ),
      ),
    );
  }
}
