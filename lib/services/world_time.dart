import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // Location name for the UI
  String time; // The time in that location
  String flag; // Url to an asset flag icon
  String url; // Location url for the api endpoint
  bool isDaytime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      // print(data);

      // Get properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // print(datetime);
      // print(offset);

      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property
      isDaytime = now.hour >= 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Could not get time data';
    }
  }
}
