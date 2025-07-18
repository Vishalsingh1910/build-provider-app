import 'package:build_provider_app/src/modules/home/home_controller.dart';
import 'package:build_provider_app/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.homeTitle)),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => controller.fetchData(),
            child: const Text("Get build"),
          ),

          ElevatedButton(
            onPressed: () => controller.triggerGitHubWorkflow(),
            child: const Text("Trigger APK Build"),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const CircularProgressIndicator();
            }
            if (controller.errorMessage.value.isNotEmpty) {
              return Text(
                "Error: ${controller.errorMessage.value}",
                style: const TextStyle(color: Colors.red),
              );
            }
            if (controller.apiresponse.value.isNotEmpty) {
              return Text(
                "Response: ${controller.apiresponse.value}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            }
            return const Text("Press the button to get build");
          }),
        ],
      ),
      // body: Text("hello this is the first screen"),
    );
  }
}
