import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/evacuation_controller.dart';

class EvacuationView extends GetView<EvacuationController> {
  const EvacuationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EvacuationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EvacuationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
