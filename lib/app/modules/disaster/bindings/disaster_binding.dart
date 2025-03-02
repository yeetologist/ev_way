import 'package:get/get.dart';

import '../controllers/disaster_controller.dart';

class DisasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DisasterController>(
      () => DisasterController(),
    );
  }
}
