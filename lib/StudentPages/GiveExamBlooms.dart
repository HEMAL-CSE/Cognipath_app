import 'package:cognipath/components/CustomAppBar.dart';
import 'package:flutter/material.dart';

class GiveExamBlooms extends StatefulWidget {
  const GiveExamBlooms({super.key});

  @override
  State<GiveExamBlooms> createState() => _GiveExamBloomsState();
}

class _GiveExamBloomsState extends State<GiveExamBlooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Blooms',),
      body: ListView(children: [
        Center(child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text('Chapter Wise Question based on Blooms:', style: TextStyle(color: Colors.purpleAccent[700], fontSize: 20, fontWeight: FontWeight.bold,),),
        ))
      ],),
    );
  }
}