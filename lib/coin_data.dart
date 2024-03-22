import 'package:bitcoin_ticker_updated/services/requests_helper.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  RequestsHelper requestsHelper = RequestsHelper({"X-CoinAPI-Key": 'bogus-key'});

  Future<String> getExchangeRate(String currency) async {
    Uri url = Uri.https('rest.coinapi.io', '/v1/exchangerate/BTC/$currency');

    dynamic response = await requestsHelper.getData(url);
    return response['rate'].toString();
  }

  Future<Map> getExchangeRates(String currency) async {
    Uri btcUrl = Uri.https('rest.coinapi.io', '/v1/exchangerate/BTC/$currency');
    Uri ethUrl = Uri.https('rest.coinapi.io', '/v1/exchangerate/ETH/$currency');
    Uri ltcUrl = Uri.https('rest.coinapi.io', '/v1/exchangerate/LTC/$currency');
    dynamic values = await Future.wait([
      requestsHelper.getData(btcUrl),
      requestsHelper.getData(ethUrl),
      requestsHelper.getData(ltcUrl)
    ]);
    String btcRate = values[0]['rate'].toInt().toString();
    String ethRate = values[1]['rate'].toInt().toString();
    String ltcRate = values[2]['rate'].toInt().toString();
    return {
      'BTC': btcRate,
      'ETH': ethRate,
      'LTC': ltcRate
    };
  }
}
