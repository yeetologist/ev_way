import 'package:ev_way/app/modules/about/controllers/about_controller.dart';
import 'package:ev_way/app/modules/disaster/controllers/disaster_controller.dart';
import 'package:ev_way/app/modules/evacuation/controllers/evacuation_controller.dart';
import 'package:ev_way/app/modules/home/controllers/home_controller.dart';
import 'package:ev_way/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/landing_controller.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingController>(() => LandingController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DisasterController>(() => DisasterController());
    Get.lazyPut<EvacuationController>(() => EvacuationController());
    Get.lazyPut<AboutController>(() => AboutController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
