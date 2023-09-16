import 'package:flutter/material.dart';

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({
     required this.title,
    required this.time,
    required this.color,
    required this.nextColor,
  });

  final String title;
  final String time;
  final Color color;
  final Color nextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: EdgeInsets.only(),
        color: nextColor,
        child: Container(
          width: 50,
          decoration: BoxDecoration(

            color: color,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(80.0),
            ),
          ),
          padding: const EdgeInsets.only(
            left: 20,
            top: 30.0,
            bottom: 40,
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  time,
                  style: TextStyle(color: Colors.white, fontSize: 12,),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  textAlign:TextAlign.center ,
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,),
                ),
                Row(),
              ]),
        ),
      ),
    );
  }
}
