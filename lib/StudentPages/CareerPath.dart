import 'dart:convert';

import 'package:cognipath/components/CustomAppBar.dart';
import 'package:cognipath/components/CustomDropdown.dart';
import 'package:flutter/cupertino.dart';
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
   
   List sectors = [];

   List careers = [];

   String? sector_id;

   bool suggestion = false;
   
   
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
   
   void getSectors() async {
     final url = Uri.parse('https://text.cognipath.net/job/sectors');

     Response res = await get(url);

     setState(() {
       sectors = jsonDecode(res.body);
     });
   }

  void getMarks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');

    final url = Uri.parse('https://text.cognipath.net/exam/school/blooms/answers?student_id=${user_id}');

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
    // In heree we update in our dates.


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
    // print(jsonDecode(res2.body));
    var resbody2 = jsonDecode(res2.body);

    var career = resbody2['career_probability'].split('     ');
    var firstData = {'name': career[0].substring(0, career[0].indexOf('(')), 'percentage': num.parse(career[0].substring(career[0].indexOf('(') + 1, career[0].indexOf('%')))};
    var secondData = {'name': career[1].substring(0, career[1].indexOf('(')), 'percentage': num.parse(career[1].substring(career[1].indexOf('(') + 1, career[1].indexOf('%')))};
    var thirdData = {'name': career[2].substring(0, career[2].indexOf('(')), 'percentage': num.parse(career[2].substring(career[2].indexOf('(') + 1, career[2].indexOf('%')))};


    setState(() {
      data = [firstData, secondData, thirdData];
    });
  }

  void getCareerPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    final url = Uri.parse('https://text.cognipath.net/job/cognitive_domain_mean?student_id=${user_id}');

    Response res = await get(url);

    print(jsonDecode(res.body));

    var resbody = jsonDecode(res.body);

    resbody.sort((a, b) {
      return a['percentage'].compareTo(b['percentage']) as int;
    });



    final url2 = Uri.parse('https://text.cognipath.net/job/competency/filter?domain_id=${resbody.last['domain_id']}&sector_id=${sector_id}');
    final url3 = Uri.parse('https://text.cognipath.net/job/competency/filter?domain_id=${resbody[resbody.length - 2]['domain_id']}&sector_id=${sector_id}');
    final url4 = Uri.parse('https://text.cognipath.net/job/competency/filter?domain_id=${resbody[resbody.length - 3]['domain_id']}&sector_id=${sector_id}');

    Response res2 = await get(url2);
    Response res3 = await get(url3);
    Response res4 = await get(url4);

    print(jsonDecode(res2.body));

    var third = {'name': resbody.last['domain'], 'percentage': resbody.last['percentage']};
    var second = {'name': resbody[resbody.length - 2]['domain'], 'percentage': resbody[resbody.length - 2]['percentage']};
    var first = {'name': resbody[resbody.length - 3]['domain'], 'percentage': resbody[resbody.length - 3]['percentage']};

    setState(() {
      suggestion = true;
      data = [first, second, third];
      careers = [jsonDecode(res2.body), jsonDecode(res3.body), jsonDecode(res4.body)];
    });
  }

  @override
  void initState() {
    // getMarks();

    getSectors();
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
            
            CustomDropdown(value: sector_id, data: sectors, onChanged: (value) {
              setState(() {
                sector_id = value;
              });
            }, fieldNames: ['name', 'id'], hint: 'Select Sector',),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff01013f),
                foregroundColor: Colors.white,
              ),
              onPressed: (){
            getCareerPath();

          }, child: Text('Get Suggested Career', style: TextStyle(fontSize: 15),)),
            
          Visibility(
            visible: suggestion,
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

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Suggested Career Path:', style: TextStyle(fontSize: 19.5, fontWeight: FontWeight.bold),),
                ),
                
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text('First Suggestions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(width: 10,),
                    if(careers.isNotEmpty)
                      for(var i in careers[0])
                        Text('${i['job_name']},')


                  ],
                ),

                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text('Second Suggestions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(width: 10,),
                    if(careers.isNotEmpty)
                      for(var i in careers[1])
                        Text('${i['job_name']},')

                  ],
                ),

                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text('Third Suggestions:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(width: 10,),
                    if(careers.isNotEmpty)
                      for(var i in careers[2])
                        Text('${i['job_name']},')

                  ],
                )

              ],
            ),
          ),
          ],
        ),
      )
    );
  }
}
