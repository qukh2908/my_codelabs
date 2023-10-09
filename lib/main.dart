import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My codelab',
      defaultTransition: Transition.cupertino,
      scrollBehavior: MyScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff202127))
            .copyWith(background: const Color(0xff202127)),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    final kWidth = MediaQuery.of(context).size.width;
    final kHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: kWidth,
        height: kHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Draggable<int>(
                  data: controller.data,
                  feedback: Container(
                    height: 50,
                    width: 50,
                    color: Colors.redAccent,
                    child: const Icon(Icons.adb, color: Colors.black12),
                  ),
                  childWhenDragging: Container(
                    height: 50,
                    width: 50,
                    color: Colors.white70,
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.redAccent,
                    child: const Icon(Icons.adb, color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                DragTarget<int>(
                  builder: (
                    context,
                    accepted,
                    rejected,
                  ) =>
                      Obx(() => controller.active.value
                          ? Container(
                              height: 50,
                              width: 50,
                              color: Colors.redAccent,
                              child: const Icon(Icons.adb, color: Colors.black))
                          : Container(
                              height: 50,
                              width: 50,
                              color: Colors.white70,
                            )),
                  onAccept: (int data) {
                    controller.data += data;
                    controller.active.value = true;
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
                ElevatedButton(
                    onPressed: () => controller.active.value = false,
                    child: const Text('reset'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}