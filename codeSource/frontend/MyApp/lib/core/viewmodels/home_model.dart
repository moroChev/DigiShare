import 'package:MyApp/core/services/publication_service.dart';
import 'package:MyApp/core/viewmodels/base_model.dart';
import 'package:MyApp/core/models/publication.dart';
import '../enum/viewstate.dart';
import 'base_model.dart';
import '../../locator.dart';


class HomeModel extends BaseModel{

  final PublicationService _postService = locator<PublicationService>();

  List<Publication> _posts;

  List<Publication> get publications => _posts;

  Future getAllPublications() async {

    setState(ViewState.Busy);
    this._posts = await _postService.fetchAllPosts();
    print('get all publications from HomeModel');
    setState(ViewState.Idle);

  }



}