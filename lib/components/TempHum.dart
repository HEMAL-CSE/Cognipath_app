import 'package:flutter/material.dart';
// import 'package:flutter_font_icons/flutter_font_icons.dart';

class TempHum extends StatefulWidget {
  final temp;
  final hum;
  const TempHum({super.key, this.temp, this.hum});

  @override
  State<TempHum> createState() => _TempHumState();
}

class _TempHumState extends State<TempHum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Colors.tealAccent,
                boxShadow: [
                  BoxShadow(
                    //offset: Offset(0, 4),
                      color: Colors.tealAccent, //edited
                      spreadRadius: 4,
                      blurRadius: 10  //edited
                  )]

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text('Temperature', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        // Icon(Entypo.thermometer, size: 34,),
                        Text('${widget.temp}\u00B0 C', style: TextStyle(fontSize: 24,  fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                )
                
              ],
            ),
          ),
          Container(
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                color: Colors.lightBlueAccent,
                boxShadow: [
                  BoxShadow(
                    //offset: Offset(0, 4),
                      color: Colors.lightBlueAccent, //edited
                      spreadRadius: 4,
                      blurRadius: 10  //edited
                  )]

            ),
            child: Column(
              children: [
                Expanded(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text('Humidity', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Icon(Icons.water_drop_outlined, size: 34,),
                        Text('${widget.hum}\u00B0 C', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
