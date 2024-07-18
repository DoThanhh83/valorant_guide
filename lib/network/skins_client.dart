
import 'package:dio/dio.dart';
import 'package:valoratn_gui/models/skins.dart';
import 'package:valoratn_gui/network/api_client.dart';

class SkinsClient extends ApiClient {
  // Get Ranks
  Future<Iterable<Skins>> getSkins() async {
    Iterable<Skins> Skinss = [];
    try {
      // Get response
      Response response =
      await super.dio.get("${super.baseUrl}v1/weapons/skinlevels/");

      // Parsed list bunu mapleyip her ranki tek tek ranks listesine atiyoruz
      List parsedList = response.data['data'];
      Skinss = parsedList.map((element) {
        return Skins.fromJson(element);
      });
    } on DioError catch (e) {
      if (e.response != null) {
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return Skinss;
  }
}
