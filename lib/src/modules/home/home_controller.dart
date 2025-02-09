import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isLoading = false.obs;
  var apiresponse = "".obs;
  var errorMessage = "".obs;

  Future<void> fetchData() async {
    isLoading.value = true;
    apiresponse.value = "";
    errorMessage.value = "";

    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
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
}
