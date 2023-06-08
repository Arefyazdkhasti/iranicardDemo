import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranicard_demo/data/model/search_query.dart';
import 'package:iranicard_demo/data/model/search_response.dart';
import 'package:iranicard_demo/data/repository/bookmark_repository.dart';
import 'package:iranicard_demo/data/repository/search_repository.dart';
import 'package:iranicard_demo/ui/LightThemeColor.dart';
import 'package:iranicard_demo/ui/seach/bloc/search_bloc.dart';
import 'package:iranicard_demo/widgets/ImageLoadingService.dart';

import '../../common/utils.dart';
import '../../data/repository/auth_repository.dart';
import '../../widgets/searchResultList.dart';
import '../bookmark/BookMarkScreen.dart';

TextEditingController _keywordController = TextEditingController();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void dispose() {
    _keywordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) {
            final bloc = SearchBloc(
                searchRepository: searchRepository,
                bookmarkRepository: bookmarkRepository);

            bloc.add(SearchStarted());
            return bloc;
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                physics: defaultScrollPhysics,
                itemCount: 3,
                itemBuilder: (contect, index) {
                  switch (index) {
                    case 0:
                      return _SearchBar();
                    //case 1:
                    //  return _Fliters();
                    case 2:
                      return BlocBuilder<SearchBloc, SearchState>(
                          /*  buildWhen: (prevoius, current) {
                        return current is SearchLoading ||
                            current is SearchError ||
                            current is SearchSuccess;
                      }, */
                          builder: (context, state) {
                        if (state is SearchSuccess) {
                          return ResultList(list: state.results);
                        } else if (state is SearchLoading) {
                          return const SizedBox(
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state is SearchInitial) {
                          return Container();
                        } else if (state is SearchError) {
                          return SizedBox(
                            height: 150,
                            child: Center(
                                child: Text(
                              state.exception.message,
                            )),
                          );
                        } else {
                          throw Exception("State Not Supported!");
                        }
                      });

                    default:
                      return Container();
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
        height: 65,
        decoration: BoxDecoration(
            color: LightThemeColor.itemBackgroundColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            InkWell(
                onTap: () => {Navigator.of(context, rootNavigator: true).pop()},
                child: const Icon(Icons.arrow_back)),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                onChanged: (text) {
                  if (text.length >= 3) {
                    BlocProvider.of<SearchBloc>(context).add(SearchQueryChanged(
                        searchQuery: SearchQuery(
                            categoryId: "",
                            tag: "",
                            moduleId: "",
                            keyword: text)));
                  }
                },
                controller: _keywordController,
                maxLines: 1,
                decoration: InputDecoration(
                    hintText: 'جست و جو',
                    hintStyle: themeData.textTheme.bodyMedium?.copyWith(
                        fontSize: 24,
                        color: LightThemeColor.secondaryColor.withOpacity(0.8)),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(Icons.search),
            const SizedBox(
              width: 12,
            ),
          ],
        ));
  }
}
