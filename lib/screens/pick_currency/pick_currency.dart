import 'package:currency_tracker/screens/pick_currency/pick_currency_controller.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

/*
  Hey there, welcome to currency tracker app. Click next to continue
*/

class PickCurrency extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PickCurrencyController>.reactive(
      viewModelBuilder: () => PickCurrencyController(),
      onModelReady: (m) => m.init(context),
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Tell us how to serve you",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          controller: controller.scrollController,
          child: Column(
            children: controller.listChildren,
          ),
        ),
      ),
    );
  }
}
