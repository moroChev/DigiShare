import 'package:flutter/material.dart';

class GradientColorStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // Adobe XD layer: 'gradient' (group)
   
    return Stack(
    children: <Widget>[
      Transform.translate(
        offset: Offset(0.0, 728.0),
        child:
            // Adobe XD layer: 'bg' (shape)
            Container(
          width: 81.5,
          height: 8.0,
          decoration: BoxDecoration(
            color: const Color(0xff665eff),
          ),
        ),
      ),
      Transform.translate(
        offset: Offset(81.47, 728.0),
        child:
            // Adobe XD layer: 'bg' (shape)
            Container(
          width: 81.5,
          height: 8.0,
          decoration: BoxDecoration(
            color: const Color(0xff5773ff),
          ),
        ),
      ),
      Transform.translate(
        offset: Offset(162.07, 728.0),
        child:
            // Adobe XD layer: 'bg' (shape)
            Container(
          width: 81.5,
          height: 8.0,
          decoration: BoxDecoration(
            color: const Color(0xff3497fd),
          ),
        ),
      ),
      Transform.translate(
        offset: Offset(243.53, 728.0),
        child:
            // Adobe XD layer: 'bg' (shape)
            Container(
          width: 81.5,
          height: 8.0,
          decoration: BoxDecoration(
            color: const Color(0xff3acce1),
          ),
        ),
      ),
    ],
  );






  }
}