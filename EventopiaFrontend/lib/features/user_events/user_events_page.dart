import 'package:awp/core/theme/colors.dart';
import 'package:awp/core/widgets/app_bar.dart';
import 'package:awp/features/event/add_event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserEventsPage extends StatelessWidget {
  UserEventsPage({super.key});

  final controller = Get.put(AddEventController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderBar(
            title: "Recommended events",
            icon: Icons.event_available_rounded,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Based on your interests, you might also like: ",
                    style: TextStyle(
                      color: AppColorScheme.darkBlue,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
