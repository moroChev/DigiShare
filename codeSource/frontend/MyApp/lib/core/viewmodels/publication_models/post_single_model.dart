import 'package:MyApp/core/services/socket_service.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/locator.dart';
import 'package:MyApp/core/services/publication_service/pub_global_Src.dart';

class SinglePostModel extends BaseModel {
  final PublicationGlobalService _postGlobalService =
      locator<PublicationGlobalService>();

  Publication _post;

  Publication get publication => _post;

  Future getSinglePublication(String publicationId) async {
    setState(ViewState.Busy);
    this._post = await this._postGlobalService.fetchSinglePost(publicationId);
    print('get Single publications from singleModel');
    setState(ViewState.Idle);
  }


}
