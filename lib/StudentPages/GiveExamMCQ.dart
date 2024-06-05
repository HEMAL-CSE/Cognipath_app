import 'package:cognipath/components/CustomAppBar.dart';
import 'package:flutter/material.dart';

class GiveExamMcq extends StatefulWidget {
  const GiveExamMcq({super.key});

  @override
  State<GiveExamMcq> createState() => _GiveExamMcqState();
}

class _GiveExamMcqState extends State<GiveExamMcq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'MCQ',),
    );
  }
}
