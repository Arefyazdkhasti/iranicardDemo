import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/utils.dart';
import '../data/model/search_response.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/bookmark_repository.dart';
import '../ui/LightThemeColor.dart';
import '../ui/bookmark/BookMarkScreen.dart';
import '../ui/seach/bloc/search_bloc.dart';
import 'ImageLoadingService.dart';

class ResultList extends StatefulWidget {
  List<SearchResponse> list;

  ResultList({required this.list});

  @override
  State<ResultList> createState() => _ResultListState();
}

class _ResultListState extends State<ResultList> {
  String accessTocken = '';

  @override
  void initState() {
    super.initState();
    authRepository.loadAuthInfo().then((result) {
      setState(() {
        accessTocken = result;
      });
    });
    bookmarkRepository.getBookmarks().then((result) {
      List<SearchResponse> updatedList = [];
      for (SearchResponse item in widget.list) {
        if (result.contains(item)) {
          item.isBookmarked = true;
        } else {
          item.isBookmarked = false;
        }
        updatedList.add(item);
      }
      setState(() {
        widget.list = updatedList;
      });
    });
  }

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
                        imageUrl: item.image,
                        borderRadius: BorderRadius.circular(8),
                        accessTocken: accessTocken,
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
                                  ?.copyWith(fontSize: 20)),
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
                          BlocProvider.of<SearchBloc>(context)
                              .add(ItemBookMarkStatusChanged(item));

                          final snackBar = SnackBar(
                            duration: const Duration(seconds: 5),
                            backgroundColor:
                                LightThemeColor.itemBackgroundColor,
                            content: Text(
                                item.isBookmarked
                                    ? '${item.name} به بوک مارک افزوده شد '
                                    : '${item.name} از بوک مارک حذف شد ',
                                style: themeData.textTheme.labelMedium),
                            action: item.isBookmarked
                                ? SnackBarAction(
                                    label: 'مشاهده',
                                    textColor: LightThemeColor.primaryColor,
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  BookMarkScreen()));
                                    },
                                  )
                                : null,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
