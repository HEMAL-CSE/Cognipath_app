import 'package:cognipath/components/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckMarks extends StatefulWidget {
  const CheckMarks({super.key});

  @override
  State<CheckMarks> createState() => _CheckMarksState();
}

class _CheckMarksState extends State<CheckMarks> {
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
                  label: Text('EXAM NAME', style: TextStyle(fontStyle: FontStyle.italic),),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'QUESTION CHAPTER',
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
                        'TOTAL SCORE', style: TextStyle(fontStyle: FontStyle.italic,),),
                    ),),
                ),
              ],
              rows: const <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('Sarah'))),
                    DataCell(Center(child: Text('19'))),
                    DataCell(Center(child: Text('Student'))),
                    DataCell(Center(child: Text('Student'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('Janine'))),
                    DataCell(Center(child: Text('43'))),
                    DataCell(Center(child: Text('Professor'))),
                    DataCell(Center(child: Text('Professor'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('William'))),
                    DataCell(Center(child: Text('27'))),
                    DataCell(Center(child: Text('Associate Professor'))),
                    DataCell(Center(child: Text('Associate Professor'))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Center(child: Text('William'))),
                    DataCell(Center(child: Text('27'))),
                    DataCell(Center(child: Text('Associate Professor'))),
                    DataCell(Center(child: Text('Associate Professor'))),
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
