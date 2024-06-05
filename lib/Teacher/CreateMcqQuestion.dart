import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:flutter/material.dart';

class CreateMcqQuestion extends StatefulWidget {
  const CreateMcqQuestion({super.key});

  @override
  State<CreateMcqQuestion> createState() => _CreateMcqQuestionState();
}

class _CreateMcqQuestionState extends State<CreateMcqQuestion> {

  String? chapter;

  List chapters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'MCQ',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomDropdown(value: chapter, data: chapters,hint: 'Chapter Name', onChanged: (value) {
              setState(() {
                chapter = value;
              });
            }, fieldNames: ['chapter_name', 'id']),
            SizedBox(height: 10,),
            
          ],
        ),
      ),
    );
  }
}
