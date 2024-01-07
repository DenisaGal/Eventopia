import 'dart:typed_data';

import 'package:awp/core/theme/colors.dart';
import 'package:awp/core/widgets/app_bar.dart';
import 'package:awp/features/event/add_event_page.dart';
import 'package:awp/features/home/home_controller.dart';
import 'package:awp/features/user_events/user_events_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderBar(
              title: "Eventopia",
              icon: Icons.home,
              onHomePressed: () {
                Get.offAll(HomePage());
              },
              secondPage: "Recommended",
              onSecondPressed: () {
                Get.to(() => UserEventsPage(), arguments: controller.userId);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          final category = controller.categories[index];

                          return Row(
                            children: [
                              Text(
                                category.name,
                                style: const TextStyle(
                                    color: AppColorScheme.orange),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Events",
                    style: TextStyle(
                        color: AppColorScheme.darkBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: SizedBox(
                        height: 620,
                        child: GridView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: controller.events.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            var event = controller.events[index];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(2, 2),
                                          blurRadius: 6)
                                    ],
                                    color: AppColorScheme.white,
                                    border: Border.all(
                                        color: AppColorScheme.darkRed),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 300,
                                  width: 400,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: Stack(
                                            children: <Widget>[
                                              Center(
                                                child: Text(
                                                  event.name,
                                                  style: const TextStyle(
                                                      color: AppColorScheme
                                                          .darkRed,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.topRight,
                                                child: Obx(
                                                  () => IconButton(
                                                    icon: Icon(
                                                        controller.userHasEvent(
                                                                event.id)
                                                            ? Icons.star_rounded
                                                            : Icons
                                                                .star_border_rounded,
                                                        color: AppColorScheme
                                                            .yellow,
                                                        size: 28),
                                                    onPressed: () async {
                                                      await controller
                                                          .editUserEvent(
                                                              event.id);
                                                    },
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          event.description,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Location: ",
                                                      style: TextStyle(
                                                          color: AppColorScheme
                                                              .darkBlue,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(event.location),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Date: ",
                                                      style: TextStyle(
                                                          color: AppColorScheme
                                                              .darkBlue,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                        "${event.date.day}/${event.date.month}/${event.date.year}"),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Fee: ",
                                                      style: TextStyle(
                                                          color: AppColorScheme
                                                              .darkBlue,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(event.cost.toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Flexible(
                                              child: Image.memory(
                                                  index <
                                                          controller
                                                              .images.length
                                                      ? controller.images[index]
                                                      : Uint8List(0),
                                                  height: 100),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemCount: event.categories?.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final category =
                                                  event.categories?[index];

                                              return Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColorScheme
                                                              .orange),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 4,
                                                        horizontal: 8,
                                                      ),
                                                      child: Text(
                                                        category?.details ?? "",
                                                        style: const TextStyle(
                                                            color:
                                                                AppColorScheme
                                                                    .orange),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  )
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300, mainAxisExtent: 400,
                            //childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.user.value?.isOrganizer ?? false,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(AddEventPage());
                        },
                        child: const Text("Add event"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
