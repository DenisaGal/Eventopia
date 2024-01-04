import 'package:awp/core/constants/paths.dart';
import 'package:awp/core/theme/colors.dart';
import 'package:awp/core/widgets/app_bar.dart';
import 'package:awp/features/event/add_event_page.dart';
import 'package:awp/features/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderBar(
            title: "Home",
            icon: Icons.home,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 20,
              //shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Text("Category ${index + 1}"),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("Most popular / recent events"),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 5,
              //controller.plantModels.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                //var plant = controller.plantModels[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColorScheme.darkRed),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        child: Image.asset(
                          Paths.logo,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offAll(AddEventPage());
            },
            child: const Text("Add event"),
          )
        ],
      ),
    );
  }
}
