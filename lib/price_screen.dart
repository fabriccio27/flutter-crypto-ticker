import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_updated/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}




class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList[0];
  String exchangeRate = '?';


  void onCurrencyChange(dynamic newCurrency) {
    // this needs to fetch data and set both select currency and exchange rate
    setState(() {
      selectedCurrency = newCurrency.toString();
    });
  }
  // need to override onInit to fetch always usd
  @override
  initState(){
    super.initState();
    getTickerData();
  }

  void getTickerData() async {
    CoinData coinService = CoinData();
    String responseRate = await coinService.getExchangeRate(selectedCurrency);
    setState(() {
      exchangeRate = responseRate;
    });

  }
  
  // then need to fetch whenever we change the currency
  // then we need to resolve multiple promises/ futures at the same time


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
          Padding(
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
                  '1 BTC = $exchangeRate USD',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
