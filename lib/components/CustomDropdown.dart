import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final value;
  final data;
  final onChanged;
  final fieldNames;
  final hint;

  const CustomDropdown({super.key,this.hint, required this.value, required this.data, required this.onChanged, required this.fieldNames});

  @override
  Widget build(BuildContext context) {
    return  Container( padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: InputDecorator(
          decoration: InputDecoration(
            border:
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0)),
            contentPadding: const EdgeInsets.all(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                isDense: true,
                value: value,
                isExpanded: true,
                menuMaxHeight: 350,
                hint: Text(hint),
                items: [
                  ...data.map<DropdownMenuItem<String>>((data) {
                    return DropdownMenuItem(
                        child: Text(data[fieldNames[0]]), value: data[fieldNames[1]].toString());
                  }).toList(),
                ],

                onChanged: onChanged),
          )

        // CustomTextField()
      ),
    );
  }
}
