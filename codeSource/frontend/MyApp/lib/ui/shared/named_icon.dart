import 'package:flutter/material.dart';

class NamedIcon extends StatelessWidget {
  final IconData iconData;
 // final String text;
  final VoidCallback onTap;
  final int notificationCount;

  const NamedIcon({
    Key key,
    this.onTap,
    @required this.iconData,
    this.notificationCount,
  }) : super(key: key);

 


  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData),
                //Text(text, overflow: TextOverflow.ellipsis),
              ],
            ),
            notificationCount > 0 ? 
            Positioned(
              top: 4.0,
              right: -1.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red[200]),
                alignment: Alignment.center,
                child: Text('$notificationCount',style: TextStyle(color: Colors.white,fontSize: 10),),
              ),
            ):
            Container(height:0,width:0),
          ],
        ),
      ),
    );
  }
}