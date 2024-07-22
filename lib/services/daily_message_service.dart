import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindlee_task/models/daily_message_model.dart';

class DailyMessageService {
  Future<List<DailyMessageModel>> fetchDailyMessages() async {
    final response = await Future.delayed(
      const Duration(seconds: 2),
      () => http.Response(
        json.encode(
          [
            {
              'id': '1',
              'title': 'Lorem Ipsum 1',
              'message':
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper eleifend. Donec accumsan, nisi ut auctor dictum, turpis eros facilisis mi, ut dictum elit libero sed lectus. Nullam et eros eget mi elementum dapibus.',
              'date': DateTime.now()
                  .subtract(const Duration(days: 4))
                  .toIso8601String(),
              'liked': false,
              'backgroundImage': 'background-1.png',
            },
            {
              'id': '2',
              'message':
                  'Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper eleifend.',
              'date': DateTime.now()
                  .subtract(const Duration(days: 3))
                  .toIso8601String(),
              'liked': true,
              'backgroundImage': 'background-2.png',
            },
            {
              'id': '3',
              'title': 'Lorem Ipsum 2',
              'message':
                  'Maecenas fermentum consequat mi. Donec fermentum. Pellentesque malesuada nulla a mi bibendum non venenatis velit molestie.',
              'date': DateTime.now()
                  .subtract(const Duration(days: 2))
                  .toIso8601String(),
              'liked': false,
              'backgroundImage': 'background-3.png',
            },
            {
              'id': '4',
              'title': 'Lorem Ipsum 3',
              'message':
                  'Nulla facilisi. Cras non dolor. Integer eget sollicitudin purus. Nullam non urna vel odio tincidunt imperdiet.',
              'date': DateTime.now()
                  .subtract(const Duration(days: 1))
                  .toIso8601String(),
              'liked': true,
              'backgroundImage': 'background-4.png',
            },
            {
              'id': '5',
              'message':
                  'Donec accumsan, nisi ut auctor dictum, turpis eros facilisis mi, ut dictum elit libero sed lectus. Nullam et eros eget mi elementum dapibus.',
              'date': DateTime.now().toIso8601String(),
              'liked': false,
              'backgroundImage': 'background-5.png',
            },
          ],
        ),
        200,
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => DailyMessageModel.fromJson(item)).toList();
    } else {
      throw Exception('Invalid response');
    }
  }
}
