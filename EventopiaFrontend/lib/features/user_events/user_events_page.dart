import 'package:awp/features/event/add_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserEventsPage extends StatelessWidget {
  UserEventsPage({super.key});

  final controller = Get.put(AddEventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}
