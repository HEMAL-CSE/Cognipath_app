import 'package:flutter/material.dart';
 // import 'package:intl/intl.dart';

class CustomTimePicker extends StatefulWidget {
  TimeOfDay time;

  final selectTime;



  final title;
   CustomTimePicker({super.key,required this.time,
    required this.selectTime,
    required this.title,});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            Text("${DateFormat('hh:mm a').format(DateFormat("hh:mm").parse(
            widget.time!.hour.toString() +
                ":" + widget.time!.minute.toString())
  )}", style: TextStyle(fontSize: 20),),
            GestureDetector(
              onTap: widget.selectTime,
              child: Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Icon(Icons.calendar_month, color: Colors.white,),
              ),
            )

          ],
        )
    );
  }
}
