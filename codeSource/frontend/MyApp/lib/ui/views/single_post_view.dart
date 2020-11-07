import 'package:MyApp/ui/widgets/publication_widgets/post_reactions/comments/post_comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:MyApp/ui/shared/sliverAppBar.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/ui/widgets/publication_widgets/single_post.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_reactions/comments/bottom_comment_area.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/core/models/employee.dart';

class SinglePostView extends StatelessWidget {
  
  final String publicationId;

  SinglePostView({@required this.publicationId});

  @override
  Widget build(BuildContext context) {
    Employee user = Provider.of<Employee>(context);
    return BaseView<SinglePostModel>(
      onModelReady: (model) => model.getSinglePublication(publicationId, user),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: Color(0xFFF5F5F8),
              bottomSheet: model.publication.isApproved
                  ? BottomCommentArea(
                                  singleComment: model.singleComment,
                                  commentTextCtrl: model.commentTextController,
                                  )
                  : Container(height: 0, width: 0),
              body: model.publication == null
                  ? Center(
                      child: Text('Cette publication n\'est plus !'),
                    )
                  : CustomScrollView(
                      slivers: <Widget>[
                        OurSliverAppBar(title: "Publication"),
                        SliverToBoxAdapter(
                          child: SinglePublicationWidget(
                              publication: model.publication,
                              poster: model.publication.postedBy),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return PostCommentTile(comment: model.comments[index]);
                            },
                            childCount: model.comments?.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox( height: 70 ),
                        )
                      ],
                    ),
            ),
    );
  }
}
