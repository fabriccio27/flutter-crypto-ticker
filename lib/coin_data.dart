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
  RequestsHelper requestsHelper = RequestsHelper({"X-CoinAPI-Key": '38E17CC5-F0F0-4535-B27F-AA04DAA61E0D'});

  Future<String> getExchangeRate(String currency) async {
    Uri url = Uri.https('rest.coinapi.io', '/v1/exchangerate/BTC/$currency');

    dynamic response = requestsHelper.getData(url);
    return response.rateData.toString();
  }
}
