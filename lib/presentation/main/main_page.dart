import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../application/application.dart';
import '../../shared/shared.dart';
import '../presentation.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BasePageState<MainPage, MainBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return AutoTabsScaffold(
      routes: navigator.tabsRoutes,
      appBarBuilder: (context, tabsRouter) {
        return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            BottomTab.values[tabsRouter.activeIndex].title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimens.d16.responsive(),
            ),
          ),
          leadingWidth: Dimens.d54.responsive(),
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: Icons.search,
              onTap: () {},
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: Dimens.d24.responsive()),
              child: Avatar.small(
                url: RandomUtils.randomPictureUrl(),
              ),
            ),
          ],
        );
      },
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) => tabsRouter.setActiveIndex(index),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: Dimens.d20.responsive(),
          elevation: 0,
          selectedFontSize: Dimens.d11.responsive(),
          unselectedFontSize: Dimens.d11.responsive(),
          type: BottomNavigationBarType.fixed,
          items: BottomTab.values
              .map(
                (tab) => BottomNavigationBarItem(
                  label: tab.name,
                  icon: Icon(tab.icon),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

enum BottomTab {
  messages,
  notifications,
  calls,
  contacts,
}

extension BottomTabExt on BottomTab {
  IconData get icon {
    switch (this) {
      case BottomTab.messages:
        return CupertinoIcons.bubble_left_bubble_right_fill;
      case BottomTab.notifications:
        return CupertinoIcons.bell_solid;
      case BottomTab.calls:
        return CupertinoIcons.phone_fill;
      case BottomTab.contacts:
        return CupertinoIcons.person_2_fill;
    }
  }

  String get title {
    switch (this) {
      case BottomTab.messages:
        return S.current.messages;
      case BottomTab.notifications:
        return S.current.notifications;
      case BottomTab.calls:
        return S.current.calls;
      case BottomTab.contacts:
        return S.current.contacts;
    }
  }
}
