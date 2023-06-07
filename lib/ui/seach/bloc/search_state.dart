part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final AppException exception;
  const SearchError({required this.exception});

  @override
  List<Object> get props => [exception];
}

class SearchSuccess extends SearchState {
  final List<SearchResponse> results;

  const SearchSuccess({required this.results});
}
