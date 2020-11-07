import 'package:flutter/material.dart';
import 'package:MyApp/ui/shared/searchBar.dart';
import 'package:MyApp/ui/widgets/notification_widgets/notification_icon.dart';


class OurSliverAppBar extends StatelessWidget {

 final String title;
 final String ancestorPath;

 OurSliverAppBar({this.title,this.ancestorPath});

  @override
  Widget build(BuildContext context) {
    print('OURSLIVER APP BAR : ${this.ancestorPath == null}');
    return  SliverAppBar(
                    iconTheme: IconThemeData(color: Colors.black45,), 
                    backgroundColor: Color(0xFFF5F5F8),
                    leading: this.ancestorPath != null ? IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () async {
                          Navigator.pop(context);
                          await Navigator.pushNamed(context, this.ancestorPath);
                        },
                      ) : null,
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