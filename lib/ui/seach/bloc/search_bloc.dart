import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranicard_demo/data/model/search_query.dart';
import 'package:iranicard_demo/data/model/search_response.dart';
import 'package:iranicard_demo/data/repository/search_repository.dart';

import '../../../common/exception.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ISearchRepository searchRepository;

  SearchBloc({required this.searchRepository}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchQueryChanged ){
        try{
          emit(SearchLoading());
          final results = await searchRepository.getResult(event.searchQuery);
          emit(SearchSuccess(results: results));
        } catch (e) {
          emit(
              SearchError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}