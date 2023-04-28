import 'dart:convert';
import '../model/models.dart';
import 'package:http/http.dart' as http;

import '../screen/global.dart';

class ApiHelpers {
  ApiHelpers._();

  static final ApiHelpers apiHelpers = ApiHelpers._();

  Future<List<Provider>?> fetchPixaBayData() async {
    String words =  Global.search;
    String baseURI =
        "https://pixabay.com/api/?key=35788272-a81d87d571ee530eb7797bdc1&q=$words&image_type=photo,per_page=70";

    String api = baseURI;
    http.Response data = await http.get(Uri.parse(api));

    if (data.statusCode == 200) {
      Map decodeData = jsonDecode(data.body);

      List post = decodeData["hits"];

      List<Provider> allData = post.map((e) => Provider.fromMap(data: e)).toList();

      return allData;
    }
    return null;
  }
}
