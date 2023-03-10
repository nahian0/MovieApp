import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myapp/dependency_injection.dart';
import 'package:myapp/features/bookmark/domain/usecases/delateBookmarkusecase.dart';
import 'package:myapp/features/bookmark/domain/usecases/getBookmarksdatausecase.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkInitial()) {
    GetBookmarksdatausecase getBookmarksdatausecase =
        sl<GetBookmarksdatausecase>();

    DelateBookmarksusecase delateBookmarksusecase =
        sl<DelateBookmarksusecase>();

    List<Map<String, dynamic>> _bookmarks = [];

    on<loadBookmarksdata>((event, emit) async {
      emit(BookmarkInitial());
      _bookmarks = await getBookmarksdatausecase();
      emit(bookmarkDataloaded(_bookmarks));
    });
    on<delateBookmarkdata>((event, emit) async {
      print(event.id);
      await delateBookmarksusecase(event.id);
      _bookmarks = await getBookmarksdatausecase();
      emit(bookmarkDataloaded(_bookmarks));
    });
  }
}
