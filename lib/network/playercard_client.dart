// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:valoratn_gui/models/playercard.dart';
import 'package:valoratn_gui/network/api_client.dart';

import '../models/agent.dart';

class PlayerCardClient extends ApiClient {
  // Get Agents
  Future<Iterable<PlayerCard>> getPlayerCard() async {
    Iterable<PlayerCard> agents = [];
    try {
      // Get response
      Response response = await super.dio.get("${super.baseUrl}v1/playercards");

      // Parsed list bunu mapleyip her ajani tek tek agents listesine atiyoruz
      List parsedList = response.data['data'];
      agents = parsedList.map((element) {
        return PlayerCard.fromJson(element);
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
    return agents;
  }
}
