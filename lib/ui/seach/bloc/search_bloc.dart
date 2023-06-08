import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranicard_demo/data/model/search_query.dart';
import 'package:iranicard_demo/data/model/search_response.dart';
import 'package:iranicard_demo/data/repository/auth_repository.dart';
import 'package:iranicard_demo/data/repository/search_repository.dart';

import '../../../common/exception.dart';
import '../../../data/repository/bookmark_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ISearchRepository searchRepository;
  final IBookmarkRepository bookmarkRepository;

  SearchBloc({required this.searchRepository, required this.bookmarkRepository})
      : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchQueryChanged) {
        try {
          emit(SearchLoading());
          final String accessTocken = await authRepository.loadAuthInfo();
          final results = await searchRepository.getResult(event.searchQuery, accessTocken);
          emit(SearchSuccess(results: results));
        } catch (e) {
          emit(SearchError(exception: e is AppException ? e : AppException()));
        }
      } else if (event is ItemBookMarkStatusChanged) {
        try {
          await bookmarkRepository.changeBookmardStatus(event.searchResponse);
          //emit(BookMarkStatusChangeSuccess());
        } catch (e) {
          emit(SearchError(exception: e is AppException ? e : AppException(message: e.toString())));
        }
      }
    });
  }
}
