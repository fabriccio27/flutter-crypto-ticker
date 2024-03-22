import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_updated/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}




class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcExchangeRate = '?';
  String ethExchangeRate = '?';
  String ltcExchangeRate = '?';
  CoinData coinService = CoinData();

  @override
  initState(){
    super.initState();
    getInitialTickersData();
  }

  void onCurrencyChange(dynamic newCurrency) async {
    Map responseRates = await coinService.getExchangeRates(newCurrency);
    setState(() {
      selectedCurrency = newCurrency.toString();
      btcExchangeRate = responseRates['BTC'];
      ethExchangeRate = responseRates['ETH'];
      ltcExchangeRate = responseRates['LTC'];
    });
  }
  
  void getInitialTickersData() async {
    Map responseRates = await coinService.getExchangeRates(selectedCurrency);
    setState(() {
      btcExchangeRate = responseRates['BTC'];
      ethExchangeRate = responseRates['ETH'];
      ltcExchangeRate = responseRates['LTC'];
    });
  }

  DropdownButton getRegularDropdown() {
   return DropdownButton(
    value: selectedCurrency,
    items: currenciesList.map(
      (e) => DropdownMenuItem(value: e, child: Text(e),)
    ).toList(),
    onChanged: onCurrencyChange,
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: onCurrencyChange,
      children: currenciesList.map((e) => Text(e)).toList()
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    }
    return getRegularDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CryptoRate(exchangeRate: btcExchangeRate, selectedCurrency: selectedCurrency, coin: 'BTC'),
          CryptoRate(exchangeRate: ethExchangeRate, selectedCurrency: selectedCurrency, coin: 'ETH'),
          CryptoRate(exchangeRate: ltcExchangeRate, selectedCurrency: selectedCurrency, coin: 'LTC'),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

class CryptoRate extends StatelessWidget {
  const CryptoRate({
    super.key,
    required this.exchangeRate,
    required this.selectedCurrency,
    required this.coin,
  });

  final String exchangeRate;
  final String selectedCurrency;
  final String coin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $coin = $exchangeRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
