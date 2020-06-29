import 'package:flutter/material.dart';
import 'package:MyApp/ui/shared/sliverAppBar.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/ui/shared/floatingButton.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/ui/widgets/publication_widgets/single_post.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';



class SinglePostView extends StatelessWidget {

  final String publicationId;

 SinglePostView({@required this.publicationId});

  @override
  Widget build(BuildContext context) {
    return BaseView<SinglePostModel>(
      onModelReady: (model)=> model.getSinglePublication(publicationId),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingButton(),
        backgroundColor: Color(0xFFF5F5F8),
        body: CustomScrollView(
          slivers: <Widget>[
            OurSliverAppBar(title: "Publication"),
             model.state == ViewState.Busy ?
            SliverFillRemaining(
              child:  Center(child: CircularProgressIndicator()),
            )
                : 
                model.publication == null ?
            SliverFillRemaining(child: Center(child: Text('Cette publication n\'est plus !'),))
                :
            SliverToBoxAdapter(child: SinglePublicationWidget(publication: model.publication, poster: model.publication.postedBy)),
                   
             
          ],
        ),
      ),
    );
  }
}