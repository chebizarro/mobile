import 'exchange_service.dart';

class YadioExchangeService extends ExchangeService {
  YadioExchangeService() : super('https://api.yadio.io/');
  
  @override
  Future<double> getExchangeRate(
    String fromCurrency,
    String toCurrency,
  ) async {
    final endpoint = 'convert/$fromCurrency/$toCurrency';
    final data = await getRequest(endpoint);

    if (data.containsKey('result')) {
      return (data['result'] as num).toDouble();
    } else {
      throw Exception('Exchange rate not found in response');
    }
  }

  @override
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


}
