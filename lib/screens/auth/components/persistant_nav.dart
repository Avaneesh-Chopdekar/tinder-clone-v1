import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:tinder/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:tinder/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:tinder/screens/home/home_screen.dart';
import 'package:tinder/screens/profile/profile_screen.dart';

class PersistantTabScreen extends StatefulWidget {
  const PersistantTabScreen({super.key});

  @override
  State<PersistantTabScreen> createState() => _PersistantTabScreenState();
}

class _PersistantTabScreenState extends State<PersistantTabScreen> {
  final PersistentTabController _controller = PersistentTabController();
  late Color dynamicColor = Theme.of(context).colorScheme.primary;

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      BlocProvider(
        create: (context) => SignInBloc(
          userRepository: context.read<AuthenticationBloc>().userRepository,
        ),
        child: const ProfileScreen(),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/tinder_logo.png',
          scale: 16,
          color: dynamicColor,
        ),
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(CupertinoIcons.chat_bubble_2_fill, size: 30),
      //   activeColorPrimary: Theme.of(context).colorScheme.primary,
      //   inactiveColorPrimary: Colors.grey,
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_fill, size: 30),
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      controller: _controller,
      items: _navBarItems(),
      onItemSelected: (value) {
        if (value == 0) {
          setState(() {
            dynamicColor = Theme.of(context).colorScheme.primary;
          });
        } else {
          setState(() {
            dynamicColor = Colors.grey;
          });
        }
      },
      confineInSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      navBarStyle: NavBarStyle.style8,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      decoration: NavBarDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 2,
          ),
        ),
        colorBehindNavBar: Colors.white,
      ),
    );
  }
}
