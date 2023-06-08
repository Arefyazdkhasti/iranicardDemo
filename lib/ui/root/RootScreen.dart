import 'package:flutter/material.dart';
import 'package:iranicard_demo/data/repository/auth_repository.dart';
import 'package:iranicard_demo/ui/auth/LoginScreen.dart';

import '../LightThemeColor.dart';
import '../dashboard/DashBoardScreen.dart';
/* 
This class is the main root screen of the app which implement BottomNavigation
It Also Support stacked bottomnavigation like instagram application
*/
class RootScreen extends StatefulWidget {
  @override
  State<RootScreen> createState() => _RootScreenState();
}

const int dashboardIndex = 0;
const int categoryIndex = 1;
const int ordersIndex = 2;
const int profileIndex = 3;

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = dashboardIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _dashboardKey = GlobalKey();
  final GlobalKey<NavigatorState> _categoryKey = GlobalKey();
  final GlobalKey<NavigatorState> _ordersKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    dashboardIndex: _dashboardKey,
    categoryIndex: _categoryKey,
    ordersIndex: _ordersKey,
    profileIndex: _profileKey
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            body: Stack(
              children: [
                IndexedStack(
                  index: selectedScreenIndex,
                  children: [
                    _navigator(
                        _dashboardKey, dashboardIndex, const DashBoardScreen()),
                    _navigator(_categoryKey, categoryIndex,
                        const Center(child: Text("دسته بندی"))),
                    _navigator(_ordersKey, ordersIndex,
                        const Center(child: Text("سفارشات"))),
                    _navigator(
                        _profileKey,
                        profileIndex,
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text("پروفایل"),
                              ElevatedButton(
                                  onPressed: () {
                                    authRepository.logout();
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()));
                                  },
                                  child: const Text('خروج از حساب کابری'))
                            ],
                          ),
                        )),
                  ],
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      // Your action here
                    },
                    backgroundColor: LightThemeColor.itemBackgroundColor,
                    label: Text('پشتیبانی',
                        style: themeData.textTheme.labelMedium
                            ?.copyWith(color: LightThemeColor.iconColos)),
                    icon: const Icon(
                      Icons.headphones,
                      color: LightThemeColor.iconColos,
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle:
                  themeData.textTheme.bodyMedium?.copyWith(fontSize: 14),
              unselectedLabelStyle:
                  themeData.textTheme.bodyMedium?.copyWith(fontSize: 14),
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: 'داشبورد',
                    activeIcon: Container(
                      width: 60,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: LightThemeColor.itemBackgroundColor),
                      child: const Icon(Icons.home),
                    )),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.category),
                  label: 'دسته بندی',
                  activeIcon: Container(
                      width: 60,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: LightThemeColor.itemBackgroundColor),
                      child: const Icon(Icons.category)),
                ),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.list),
                    label: 'سفارشات',
                    activeIcon: Container(
                      width: 60,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: LightThemeColor.itemBackgroundColor),
                      child: const Icon(Icons.list),
                    )),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: 'پروفایل',
                  activeIcon: Container(
                      width: 60,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: LightThemeColor.itemBackgroundColor),
                      child: const Icon(Icons.person)),
                )
              ],
              currentIndex: selectedScreenIndex,
              onTap: (selectedIndex) {
                setState(() {
                  setState(() {
                    _history.remove(selectedScreenIndex);
                    _history.add(selectedScreenIndex);
                    selectedScreenIndex = selectedIndex;
                  });
                });
              },
              unselectedItemColor: Colors.black,
              selectedItemColor: LightThemeColor.primaryColor,
            ),
          )),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }
}
