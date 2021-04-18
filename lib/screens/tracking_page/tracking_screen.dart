import 'package:currency_tracker/screens/pick_currency/pick_currency_controller.dart';
import 'package:currency_tracker/screens/tracking_page/tracking_controller.dart';
import 'package:currency_tracker/services/currencies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class TrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrackingController>.reactive(
      viewModelBuilder: () => TrackingController(),
      onModelReady: (m) => m.init(context),
      builder: (context, controller, child) {
        return controller.status == ViewStatus.Loading
            ? Center(child: loader)
            : Container(
                child: TrackAllCurrencies(),
              );
      },
    );
  }
}

class TrackAllCurrencies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CurrenciesService>(context);
    var children = <Widget>[];
    provider.selectedCurrencies.keys.forEach((element) {
      children.add(
        CurrencyTrackingWidget(
          currency: element,
        ),
      );
    });
    return ListView(
      children: children,
    );
  }
}

class CurrencyTrackingWidget extends StatelessWidget {
  final String currency;

  const CurrencyTrackingWidget({Key key, this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CurrenciesService>(context);

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.selectedCurrencies[currency].description ?? " ",
                    style: TextStyle(color: Colors.green, fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Rate: "),
                      Text(
                        "${provider.selectedCurrencies[currency].rate ?? " "}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Updated at: "),
                      Text(
                        "${provider.selectedCurrencies[currency].updated ?? " "}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              provider.selectedCurrencies[currency].code,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }
}
