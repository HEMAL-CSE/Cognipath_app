import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {

  DateTime? date;

  final selectDate;



  final title;

   CustomDatePicker({super.key, required this.date,
    required this.selectDate,
     required this.title,
    });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {



    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            Text("${widget.date != null ? widget.date!.toLocal() : ''}".split(' ')[0], style: TextStyle(fontSize: 20),),
            GestureDetector(
              onTap: widget.selectDate,
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
