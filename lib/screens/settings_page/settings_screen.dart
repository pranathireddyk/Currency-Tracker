import 'package:currency_tracker/services/api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsScreen extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController(
    text: "${APIService.refreshTime}",
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          title: Text("Settings screen"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 32.0),
              Text(
                "Refresh after",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: textEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Select seconds',
                ),
              ),
              SizedBox(height: 16.0),
              RaisedButton(
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                onPressed: () => updateRefreshTime(context),
                child: Text('UPDATE'),
              ),
              SizedBox(height: 16.0),
              Text(
                "Update currencies to track",
                style: Theme.of(context).textTheme.headline6,
              ),
              RaisedButton(
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                onPressed: () {},
                child: Text('RESET COUNTRIES'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  updateRefreshTime(BuildContext context) {
    try {
      int seconds = int.parse(textEditingController.text);
      APIService.refreshTime = seconds;
      FocusScope.of(context).requestFocus(FocusNode());
      Fluttertoast.showToast(msg: "Refresh time updated");
    } catch (err) {
      debugPrint("Invalid seconds");
    }
  }
}
