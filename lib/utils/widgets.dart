import 'dart:io';

import 'package:currency_tracker/services/currencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Message extends StatelessWidget {
  final String data;

  const Message({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.all(4.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            data,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

final top = ["INR", "USD", "EUR", "KWD", "AED"];

class ShowTopCurrencies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: List.generate(
            top.length,
            (index) => CurrencyWidget(
              currency: top[index],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowAllCurrencies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CurrenciesService>(context);
    var children = <Widget>[];
    provider.currencies.forEach((key, value) {
      children.add(CurrencyWidget(currency: key));
    });
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: children,
        ),
      ),
    );
  }
}

class CurrencyWidget extends StatelessWidget {
  final String currency;

  const CurrencyWidget({Key key, this.currency}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CurrenciesService>(context);
    return GestureDetector(
      onTap: () =>
          provider.selectOrDeselectCurrency(provider.currencies[currency]),
      child: Card(
        margin: const EdgeInsets.all(4.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
        elevation:
            provider.selectedCurrencies.containsKey(currency) ? 8.0 : 4.0,
        color: provider.selectedCurrencies.containsKey(currency)
            ? Colors.blue
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            "${provider.currencies[currency].country} - ${provider.currencies[currency].currency}",
            style: TextStyle(
                color: provider.selectedCurrencies.containsKey(currency)
                    ? Colors.white
                    : Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class AppPlatformButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double elevation;
  final TextStyle style;
  final EdgeInsets padding;
  final double height, width, borderRadius;
  final Widget customChild;

  const AppPlatformButton(
      {Key key,
      this.onPressed,
      this.text,
      this.color = Colors.greenAccent,
      this.elevation = 4.0,
      this.style,
      this.padding,
      this.height,
      this.width,
      this.borderRadius = 16.0,
      this.customChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textChild = Text(
      text?.toUpperCase(),
      style: style ??
          TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
    );

    final child = customChild != null
        ? customChild
        : (height != null && width != null
            ? SizedBox(
                height: height,
                width: width,
                child: Center(child: textChild),
              )
            : textChild);

    return Platform.isIOS
        ? CupertinoButton(
            padding: padding,
            borderRadius: BorderRadius.circular(borderRadius),
            color: color ?? Theme.of(context).primaryColor,
            child: child,
            onPressed: onPressed,
          )
        : RaisedButton(
            padding: padding,
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            color: color ?? Theme.of(context).primaryColor,
            child: child,
            onPressed: onPressed,
          );
  }
}
