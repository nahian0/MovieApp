import 'package:myapp/core/data/source/bookmarkLocalDatabase.dart';
import 'package:myapp/core/model/api_response.dart';
import 'package:myapp/features/details/domain/repositories/details_repository.dart';

class detailReposotoryImpl extends DetailspageRepository {
  @override
  Future<List> getDetails(String title) async {
    final response = await BookmarkLocalDb.getItem(title);
    return response;
  }

  @override
  Future<int> createitem(String title, String Description, String Vote_Average,
      String Poster_path) async {
    final response = await BookmarkLocalDb.createItem(
        title, Description, Vote_Average, Poster_path);

    return response;
  }

  @override
  Future<int> Delateitem(String title) async {
    await BookmarkLocalDb.deleteItembytitle(title);
    return 0;
  }
}
