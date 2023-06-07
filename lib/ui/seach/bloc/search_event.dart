part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchStarted extends SearchEvent{
  
}


class SearchQueryChanged extends SearchEvent{
  final SearchQuery searchQuery;
  const SearchQueryChanged({required this.searchQuery});
}