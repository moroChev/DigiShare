import 'package:flutter/material.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_elements/post_settings.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class PostShareIcon extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Icon(Icons.share,color: Colors.grey[400],size: 20.0,),
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      print('Share ... ${Provider.of<SinglePostModel>(context, listen: false).nbrOfLikes}');
                      return ListTile(
                        title: Text('Envoyer en message'),
                        leading: Icon(FontAwesomeIcons.facebookMessenger),
                      );
                    }),
                ),
              ],
            ),
    );
  }
}