import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/disaster_controller.dart';

class DisasterView extends GetView<DisasterController> {
  const DisasterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DisasterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DisasterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
