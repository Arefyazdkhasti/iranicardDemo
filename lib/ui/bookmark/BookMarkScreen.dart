import 'package:flutter/material.dart';
import 'package:iranicard_demo/data/model/search_response.dart';
import 'package:iranicard_demo/data/repository/auth_repository.dart';
import 'package:iranicard_demo/data/repository/bookmark_repository.dart';

import '../../common/utils.dart';
import '../../widgets/ImageLoadingService.dart';
import '../LightThemeColor.dart';

class BookMarkScreen extends StatefulWidget {
  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  List<SearchResponse> list = [];
  String accessTocken = "";
  @override
  void initState() {
    super.initState();
    bookmarkRepository.getBookmarks().then((result) {
      setState(() {
        list = result;
      });
    });
     authRepository.loadAuthInfo().then((result) {
      setState(() {
        accessTocken = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: LightThemeColor.backgroundColor ,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 12,),
              Expanded(
                child: ListView.builder(
                  physics: defaultScrollPhysics,
                  itemCount: list.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    SearchResponse item = list[index];
                    
                    // Build your widget tree here
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
                                imageUrl:item.image,
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
                            const SizedBox(
                              width: 12,
                            ),
                          ]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
