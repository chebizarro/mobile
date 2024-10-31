import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mostro_mobile/data/models/conversion_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExchangeService {
  final String baseUrl;

  ExchangeService(this.baseUrl);

  Future<Map<String, dynamic>> getRequest(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }


  Future<ConversionResult?> convertCurrency({
    required int amount,
    required String fromCurrency,
    required String toCurrency,
  }) async {
    final String cacheKey = 'convert_${amount}_${fromCurrency}_$toCurrency';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(cacheKey)) {
      final String? cachedData = prefs.getString(cacheKey);
      if (cachedData != null) {
        final Map<String, dynamic> jsonResponse = json.decode(cachedData);
        final int cachedTimestamp = jsonResponse['timestamp'];
        final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

        if (currentTimestamp - cachedTimestamp < 3600000) {
          return ConversionResult.fromJson(jsonResponse['result']);
        }
      }
    }

    final ConversionResult? result =
        await _performApiCall(amount, fromCurrency, toCurrency);

    if (result != null) {
      prefs.setString(
          cacheKey,
          json.encode({
            'result': result.toJson(),
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          }));
    }

    return result;
  }

  Future<ConversionResult?> _performApiCall(
      int amount, String from, String to) async {
    final String endpoint = '$_baseUrl/convert/$amount/$from/$to';
    final Uri url = Uri.parse(endpoint);

    try {
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return ConversionResult.fromJson(jsonResponse);
      } else {
        // Handle non-200 responses
        print(
            'Failed to convert currency. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return null;
      }
    } catch (e) {
      // Handle exceptions such as network errors
      print('Error occurred while converting currency: $e');
      return null;
    }
  }
}

extension ConversionResultExtension on ConversionResult {
  Map<String, dynamic> toJson() {
    return {
      'request': {
        'amount': request.amount,
        'from': request.from,
        'to': request.to,
      },
      'result': result,
      'rate': rate,
      'timestamp': timestamp,
    };
  }
}
