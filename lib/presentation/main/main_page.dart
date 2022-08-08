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
        navigator.tabsRouter = tabsRouter;

        return AppBar(
          iconTheme: Theme.of(context).iconTheme,
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
              child: Hero(
                tag: 'hero-profile-picture',
                child: Avatar.small(
                  url: AppStreamChat.instance.currentUserImage,
                  onTap: () => navigator.push(const ProfileRoute()),
                ),
              ),
            ),
          ],
        );
      },
      bottomNavigationBuilder: (context, tabsRouter) {
        return _BottonNavigationBar(
          activeIndex: tabsRouter.activeIndex,
          onItemSelected: tabsRouter.setActiveIndex,
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

class _BottonNavigationBar extends StatelessWidget {
  const _BottonNavigationBar({
    required this.activeIndex,
    required this.onItemSelected,
    Key? key,
  }) : super(key: key);

  final int activeIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: EdgeInsets.only(
            top: Dimens.d16.responsive(),
            left: Dimens.d8.responsive(),
            right: Dimens.d8.responsive(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                lable: BottomTab.messages.title,
                icon: BottomTab.messages.icon,
                isSelected: BottomTab.messages.index == activeIndex,
                onTap: () => onItemSelected.call(
                  BottomTab.messages.index,
                ),
              ),
              _NavigationBarItem(
                lable: BottomTab.notifications.title,
                icon: BottomTab.notifications.icon,
                isSelected: BottomTab.notifications.index == activeIndex,
                onTap: () => onItemSelected.call(
                  BottomTab.notifications.index,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.d8.responsive()),
                child: GlowingActionButton(
                  color: AppColors.secondary,
                  icon: CupertinoIcons.add,
                  onPressed: () {
                    showDialog<dynamic>(
                      context: context,
                      builder: (BuildContext context) => const Dialog(
                        child: AspectRatio(
                          aspectRatio: 8 / 7,
                          child: ContactsPage(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              _NavigationBarItem(
                lable: BottomTab.calls.title,
                icon: BottomTab.calls.icon,
                isSelected: BottomTab.calls.index == activeIndex,
                onTap: () => onItemSelected.call(
                  BottomTab.calls.index,
                ),
              ),
              _NavigationBarItem(
                lable: BottomTab.contacts.title,
                icon: BottomTab.contacts.icon,
                isSelected: BottomTab.contacts.index == activeIndex,
                onTap: () => onItemSelected.call(
                  BottomTab.contacts.index,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    required this.lable,
    required this.icon,
    required this.onTap,
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  final String lable;
  final IconData icon;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: Dimens.d70.responsive(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: Dimens.d22.responsive(),
              color: isSelected ? AppColors.secondary : null,
            ),
            SizedBox(
              height: Dimens.d8.responsive(),
            ),
            Text(
              lable,
              style: isSelected
                  ? TextStyle(
                      fontSize: Dimens.d11.responsive(),
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    )
                  : TextStyle(
                      fontSize: Dimens.d11.responsive(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
