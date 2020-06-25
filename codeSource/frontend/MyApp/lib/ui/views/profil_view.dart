import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/viewmodels/profil_model.dart';
import 'package:MyApp/ui/shared/CustomAppBar.dart';
import 'package:MyApp/ui/shared/divider_with_title.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/ui/widgets/profil_widgets/profil_publications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/ui/widgets/profil_widgets/profil_header.dart';
import 'package:MyApp/ui/widgets/profil_widgets/profil_activities.dart';
import 'package:MyApp/ui/widgets/profil_widgets/profil_infos.dart';
import 'package:MyApp/ui/shared/SideMenuWidget.dart';
import 'package:MyApp/ui/shared/floatingButton.dart';


class ProfilView extends StatelessWidget {
  final String idEmployee;

  ProfilView({@required this.idEmployee});

  @override
  Widget build(BuildContext context) {
    // if no parameter passed to this view , by default we display the logged in user's profile
    //else we consider user's id parameter
    var userId = idEmployee == null ? Provider.of<Employee>(context).id : idEmployee;
    // in the rest of this view we will use userId variable instead of id
    return BaseView<ProfilModel>(
      onModelReady: (model)=>model.fetchProfilData(idEmployee),
      builder: (context, model, child) => Scaffold(
        drawer: SideMenuWidget(),
        floatingActionButton: FloatingButton(),
        appBar: CustomAppBar(height: 60,),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
              : Container(
                decoration: gradientColors(),
                child: ListView(
                  children: <Widget>[
                    ProfilHeader(employee: model.employee),
                    ProfilActivities(employee: model.employee),
                    ProfilInfos(employee: model.employee),
                    DividerWithTitle(title: "Publications"),
                    ProfilPublications(publications: model.employee?.publicationsObjects, employee: model.employee)      
                  ],
              ),
            ),
       ),
    );
  }


  BoxDecoration gradientColors(){
    return BoxDecoration(
              gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF7F7F7), Colors.blue[50]]
             )
          );
  }


  
}
