import 'package:get/get.dart';

import '../controllers/evacuation_controller.dart';

class EvacuationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EvacuationController>(
      () => EvacuationController(),
    );
  }
}
