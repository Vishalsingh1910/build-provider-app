import 'dart:convert';
import 'package:build_provider_app/src/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = false.obs;
  var apiresponse = "".obs;
  var errorMessage = "".obs;

  Future<void> fetchData() async {
    debugPrint('🔗 Triggering GitHub workflow...121212121212121');
    isLoading.value = true;
    apiresponse.value = "";
    errorMessage.value = "";

    try {
      final response = await http.get(Uri.parse(AppConstants.baseUrl));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        apiresponse.value = data["title"];
      } else {
        errorMessage.value = "Error failed to load data";
      }
    } catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> triggerGitHubWorkflow() async {
    debugPrint('🔗 Triggering GitHub workflow...');
    final githubToken = dotenv.env['GITHUB_TOKEN'];
    debugPrint('Loaded GitHub Token: $githubToken');

    const repoOwner = 'Vishalsingh1910';
    const repoName = 'cooking_buddy';

    if (githubToken == null || githubToken.isEmpty) {
      debugPrint('❌ GitHub token not found in .env');
      return;
    }

    final url = Uri.parse(
      'https://api.github.com/repos/$repoOwner/$repoName/actions/workflows/build.yml/dispatches',
    );

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $githubToken',
        'Accept': 'application/vnd.github+json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'ref': 'main', // branch you want to trigger workflow on
      }),
    );

    if (response.statusCode == 204) {
      debugPrint('✅ Build triggered successfully!');
    } else {
      debugPrint('❌ Failed to trigger build: ${response.statusCode}');
      debugPrint('Response: ${response.body}');
    }
  }
}
