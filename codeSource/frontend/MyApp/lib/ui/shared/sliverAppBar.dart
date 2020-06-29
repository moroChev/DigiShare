import 'package:flutter/material.dart';
import 'package:MyApp/ui/shared/searchBar.dart';
import 'package:MyApp/ui/widgets/notification_widgets/notification_icon.dart';


class OurSliverAppBar extends StatelessWidget {

 final String title;

 OurSliverAppBar({this.title});

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
                    iconTheme: IconThemeData(color: Colors.black45,), 
                    backgroundColor: Color(0xFFF5F5F8),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[ 
                        NotificationIcon(),
                        SearchBar(),
                        ],
                      ),
                    pinned: true,
                    floating: false,
                    expandedHeight: 100.0,
                    flexibleSpace: FlexibleSpaceBar( title: Text(title,style: TextStyle(fontSize: 20, fontFamily: "Times",color: Colors.black))),
            );
  }
}