import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/core/models/publication.dart';
import '../enum/viewstate.dart';
import 'base_model.dart';
import '../../locator.dart';
import 'package:MyApp/core/services/publication_service/pub_global_Src.dart';


class HomeModel extends BaseModel{

  PublicationGlobalService _postGlobalService = locator<PublicationGlobalService>();

  List<Publication> _posts;

  List<Publication> get publications => _posts;

  Future getAllPublications() async {

    setState(ViewState.Busy);
    this._posts = await _postGlobalService.fetchAllPosts();
    print('get all publications from HomeModel');
    setState(ViewState.Idle);

  }



}