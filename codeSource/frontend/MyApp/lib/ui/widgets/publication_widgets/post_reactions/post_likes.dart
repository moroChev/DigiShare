import 'package:flutter/material.dart';
import 'package:MyApp/ui/shared/CustomAppBar.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/core/viewmodels/post_reactions_model.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_list_tile.dart';

class LikesWidget extends StatelessWidget {

  final String publicationId;
  
  LikesWidget({@required this.publicationId});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.getAppBar(context),
        backgroundColor: Color(0xFFf4f6ff),
        body: BaseView<PostReactionsModel>(
                onModelReady: (model) => model.getLikes(publicationId),
                builder: (context, model, child) => 
                model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Padding(
                         padding: EdgeInsets.only(left: 35,top: 25,bottom: 25),
                         child:Text("Likes ${model.employeesWhoLiked.length}",style: TextStyle(fontSize: 40, fontFamily: "Times"),) ,
                         ),
                        Expanded(
                            child: ListView.builder(
                              itemCount: model.employeesWhoLiked.length,
                              itemBuilder: (context,index){
                                return EmployeeListTile(employee : model.employeesWhoLiked[index], agency: model.employeesWhoLiked[index].agency);
                                }
                            ),
                         ),
                     ],
                   ),
                ),
              );
            }
  }


  

