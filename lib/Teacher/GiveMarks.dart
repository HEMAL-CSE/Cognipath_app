import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GiveMarks extends StatefulWidget {
  const GiveMarks({super.key});

  @override
  State<GiveMarks> createState() => _GiveMarksState();
}

class _GiveMarksState extends State<GiveMarks> {

  String? chapter;
  List chapters = [];
  List questions = [];

  String? category;
  List categories = [
    {'name':'blooms'}, {'name':'mcq'}
  ];

  getChapters() async {
    final url = Uri.parse('http://68.178.163.174:5001/chapter/');

    Response res = await get(url);

    setState(() {
      chapters = jsonDecode(res.body);
    });
  }

  @override void initState() {
    // TODO: implement initState
    super.initState();
    getChapters();
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

            }, child: Text('Search'))
          ],
        ),
      ),
    );
  }
}
