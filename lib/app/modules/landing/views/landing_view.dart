import 'package:ev_way/app/modules/about/views/about_view.dart';
import 'package:ev_way/app/modules/disaster/views/disaster_view.dart';
import 'package:ev_way/app/modules/evacuation/views/evacuation_view.dart';
import 'package:ev_way/app/modules/home/views/home_view.dart';
import 'package:ev_way/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  LandingView({super.key});
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withValues(alpha: 0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            showSelectedLabels: false,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex.value,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            unselectedItemColor: Color(0xFFA0B0CF),
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home_inactive.svg',
                    height: 20,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/icons/home_active.svg',
                    height: 20,
                  ),
                  label: 'Home',
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/disaster_inactive.svg',
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/disaster_active.svg',
                  height: 20,
                ),
                label: 'Disaster',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/evacuation_inactive.svg',
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/evacuation_active.svg',
                  height: 20,
                ),
                label: 'Evacuation',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.info_outline_rounded,
                  size: 20.0,
                ),
                activeIcon: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF22BBC5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: 20.0,
                    color: Color.fromARGB(255, 39, 147, 154),
                  ),
                ),
                label: 'About',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/person_inactive.svg',
                  height: 20,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/icons/person_active.svg',
                  height: 20,
                ),
                label: 'Profile',
                backgroundColor: Colors.white,
              ),
            ],
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationMenu(context),
      body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children: [
              HomeView(),
              DisasterView(),
              EvacuationView(),
              AboutView(),
              ProfileView(),
            ],
          )),
    );
  }
}
