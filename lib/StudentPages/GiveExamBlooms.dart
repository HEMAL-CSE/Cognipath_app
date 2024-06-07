import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomTextField.dart';
import 'package:flutter/material.dart';

class GiveExamBlooms extends StatefulWidget {
  const GiveExamBlooms({super.key});

  @override
  State<GiveExamBlooms> createState() => _GiveExamBloomsState();
}

class _GiveExamBloomsState extends State<GiveExamBlooms> {
  TextEditingController question1 = TextEditingController();
  TextEditingController question2 = TextEditingController();


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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Card(

                  elevation: 5,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          'Remembering involves recalling information without necessarily understanding it deeply. In this question, the focus is on recalling the types of rocks and their formation processes.Understanding requires comprehension and the ability to explain concepts.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'a) What are the three main types of rock, and how are they formed? [Remember] [4].',
                            style: TextStyle(fontSize: 15),
                          ),
                          ),
                        CustomTextField(controller: question1, hintText: 'Answer the Question:', obscureText: false, textinputtypephone: false, maxLines: 5,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'b) What is the chemical formula for water, and what are its physical states at room temperature? [Remember] [4].',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        CustomTextField(controller: question2, hintText: 'Answer the Question:', obscureText: false, textinputtypephone: false, maxLines: 5,)
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
