import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranicard_demo/data/model/search_query.dart';
import 'package:iranicard_demo/data/model/search_response.dart';
import 'package:iranicard_demo/data/repository/search_repository.dart';
import 'package:iranicard_demo/ui/LightThemeColor.dart';
import 'package:iranicard_demo/ui/seach/bloc/search_bloc.dart';
import 'package:iranicard_demo/widgets/ImageLoadingService.dart';

import '../../common/utils.dart';

TextEditingController _keywordController = TextEditingController();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) {
            final bloc = SearchBloc(searchRepository: searchRepository);

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
                    case 1:
                      return _Fliters();
                    case 2:
                      return BlocBuilder<SearchBloc, SearchState>(
                          buildWhen: (prevoius, current) {
                        return current is SearchLoading ||
                            current is SearchError ||
                            current is SearchSuccess;
                      }, builder: (context, state) {
                        if (state is SearchSuccess) {
                          return _ResultList(list: state.results);
                        } else if (state is SearchLoading) {
                          return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }else if(state is SearchInitial){
                          return Container();
                        }
                         else if (state is SearchError) {
                          return Expanded(
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

class _ResultList extends StatefulWidget {
  List<SearchResponse> list;

  _ResultList({required this.list});

  @override
  State<_ResultList> createState() => _ResultListState();
}

class _ResultListState extends State<_ResultList> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Expanded(
      child: ListView.builder(
          physics: defaultScrollPhysics,
          itemCount: widget.list.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            SearchResponse item = widget.list[index];

            return Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    SizedBox(
                      width: 65,
                      height: 65,
                      child: ImageLoadingService(
                        imageUrl: widget.list[index].image,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(item.name,
                              style: themeData.textTheme.titleLarge
                                  ?.copyWith(fontSize: 24)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(item.type,
                              style: themeData.textTheme.bodyMedium?.copyWith(
                                  color: LightThemeColor.primaryTextColor
                                      .withOpacity(0.5))),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // Toggle the value of isBookmarked for the corresponding item in the list
                          item.isBookmarked = !item.isBookmarked;
                        });
                      },
                      icon: Icon(
                        item.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: item.isBookmarked
                            ? LightThemeColor.primaryColor
                            : LightThemeColor.secondaryTextColor,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ]),
                ),
              ),
            );
          }),
    );
  }
}

class _Fliters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Row(
        children: [
          _FilterItem(
            icon: Icon(Icons.done),
          ),
          SizedBox(
            width: 12,
          ),
          _FilterItem(
            icon: Icon(CupertinoIcons.globe),
          ),
        ],
      ),
    );
  }
}

class _FilterItem extends StatelessWidget {
  final Icon icon;

  const _FilterItem({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: LightThemeColor.itemBackgroundColor,
          borderRadius: BorderRadius.circular(4)),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            const SizedBox(
              width: 8,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'test',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(Icons.arrow_drop_down_sharp)
          ]),
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
                  BlocProvider.of<SearchBloc>(context).add(SearchQueryChanged(
                      searchQuery: SearchQuery(
                          categoryId: "",
                          tag: "",
                          moduleId: "",
                          keyword: text)));
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
