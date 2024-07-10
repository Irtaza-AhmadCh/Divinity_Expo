import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import '../../resourses/colors.dart';
import '../HomeScreen.dart';
import '../Profile.dart';
import '../SponsorsrScreen.dart';


class NavigationbarScreen extends StatefulWidget {
  const NavigationbarScreen({super.key});

  @override
  State<NavigationbarScreen> createState() => _NavigationbarScreenState();
}

class _NavigationbarScreenState extends State<NavigationbarScreen> {
  final NotchBottomBarController _controller =
  NotchBottomBarController(index: 1);

  List BodyScreen = [
  SponserScreen(),
  Homescreen(),
    ProfileScreen()
  ];

  int screenIndex =1;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width*(1/360);

    return  Scaffold(
      body: BodyScreen[screenIndex],

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedNotchBottomBar(
              bottomBarWidth: 310*w,

                elevation: 100,
                notchColor: MyColors.bgBlue,
                kBottomRadius: 50,
                circleMargin: 20,
                showTopRadius: false,
                notchBottomBarController: _controller,
                onTap: (int index) {
                  setState(() {

                  });
                  screenIndex = index;
                },
                kIconSize: 20,
                bottomBarItems: [
                  BottomBarItem(
                    inActiveItem: Image.asset('assets/Sponsors_icon/icon_b.png'),
                    activeItem:Center(child: Image.asset('assets/Sponsors_icon/icon_w.png')),
                    itemLabel: 'Sponsors',
                  ),

                  BottomBarItem(
                    inActiveItem: Image.asset('assets/home_icon_inactive/icon.png'),
                    activeItem:Center(child: Image.asset('assets/home_icon_active/icon.png')),
                    itemLabel: 'Home',
                  ),

                  BottomBarItem(
                    inActiveItem: Center(child: Image.asset('assets/man-head/man-head_b.png',)),
                    activeItem:Image.asset('assets/man-head/man-head_w.png'),
                    itemLabel: 'Profile',
                  ),

                ]),
          ],
        ),
      ),
    );
  }
}
