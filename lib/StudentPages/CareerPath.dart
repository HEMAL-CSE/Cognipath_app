import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CareerPath extends StatefulWidget {
  const CareerPath({super.key});

  @override
  State<CareerPath> createState() => _CareerPathState();
}

class _CareerPathState extends State<CareerPath> {
   List data = [];
  late TooltipBehavior _tooltip;
   Map totalMarks = {
     "Stdent ID": 0,
     "Remembering": 0,
     "Understanding": 0,
     "Applying": 0,
     "Analyzing": 0,
     "Evaluation": 0,
     "Creating": 0
   };

  void getMarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');

    final url = Uri.parse('http://68.178.163.174:5001/exam/school/blooms/answers?student_id=${user_id}');

    Response res = await get(url);

    var resbody = jsonDecode(res.body);
    // print(resbody);

    for(var i in resbody){
      // print(i['domain']);
      totalMarks[i['domain']] += i['marks'] != null ? num.parse(i['marks']) : 0;
      totalMarks['Stdent ID'] = num.parse(user_id!);
    }

    // totalMarks['Stdent ID'] = totalMarks['Stdent ID'].toString();
    // totalMarks['Remembering'] = totalMarks['Stdent ID'].toString();
    // totalMarks['Understanding'] = totalMarks['Stdent ID'].toString();
    // totalMarks['Applying'] = totalMarks['Stdent ID'].toString();
    // totalMarks['Analyzing'] = totalMarks['Stdent ID'].toString();
    // totalMarks['Evaluation'] = totalMarks['Stdent ID'].toString();
    // totalMarks['Creating'] = totalMarks['Stdent ID'].toString();


    // List result = resbody
    //     .fold({}, (previousValue, element) {
    //   Map val = previousValue as Map;
    //   // print(val);
    //   // element['total_marks'] = 0;
    //   var id = element['domain'];
    //   if (!val.containsKey(id)) {
    //     val[id] = [];
    //   }
    //   // totalMarks[id] += num.parse(element['marks']);
    //   print(totalMarks[val['domain']]);
    //   totalMarks['Stdent ID'] = num.parse(user_id!);
    //   element.remove('domain');
    //   val[id]?.add(element);
    //   return val;
    // })
    //     .entries
    //     .map((e) => {e.key: e.value})
    //     .toList();

    // print(result);
    // print(totalMarks);
    
    final url2 = Uri.parse('http://68.178.163.174:5500/predict');

    Response res2 = await post(url2, body: jsonEncode(totalMarks),  headers: {"Content-Type": "application/json"});
    print(jsonDecode(res2.body));
    var resbody2 = jsonDecode(res2.body);

    var career = resbody2['career_probability'].split('     ');
    var firstData = {'name': career[0].substring(0, career[0].indexOf('(')), 'percentage': num.parse(career[0].substring(career[0].indexOf('(') + 1, career[0].indexOf('%')))};
    var secondData = {'name': career[1].substring(0, career[1].indexOf('(')), 'percentage': num.parse(career[1].substring(career[1].indexOf('(') + 1, career[1].indexOf('%')))};
    var thirdData = {'name': career[2].substring(0, career[2].indexOf('(')), 'percentage': num.parse(career[2].substring(career[2].indexOf('(') + 1, career[2].indexOf('%')))};


    setState(() {
      data = [firstData, secondData, thirdData];
    });
  }

  @override
  void initState() {
    getMarks();
    // data = [
    //   {
    //     'name': 'Doctor',
    //     'percentage': 70
    //   },
    //   {
    //     'name': 'Engineer',
    //     'percentage': 50,
    //   },
    //   {
    //     'name': 'Architect',
    //     'percentage': 30,
    //   }
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Career Path',),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(minimum: 0, maximum: 100, interval: 10),
                tooltipBehavior: _tooltip,
                series: <CartesianSeries<dynamic, String>>[
                  BarSeries<dynamic, String>(
                      dataSource: data,
                      xValueMapper: ( data, _) => data['name'],
                      yValueMapper: ( data, _) => data['percentage'],
                      name: 'Career',
                      color: Color.fromRGBO(8, 142, 255, 1))
                ]),
          ],
        ),
      )
    );
  }
}
