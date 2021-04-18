import 'package:currency_tracker/utils/widgets.dart';
import 'package:currency_tracker/screens/tabs_page/tabs_screen.dart';
import 'package:currency_tracker/services/currencies.dart';
import 'package:currency_tracker/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

final loader = SpinKitThreeBounce(
  size: 32.0,
  duration: const Duration(milliseconds: 1200),
  color: Colors.blue,
);

enum CurrentStage {
  Idle,
  WelcomeUser,
  PickTopCountries,
  PickAllCountries,
  Finish
}

class PickCurrencyController with ChangeNotifier {
  BuildContext context;
  List<Widget> _listChildren = [loader];
  final ScrollController scrollController = ScrollController();

  CurrentStage _stage = CurrentStage.Idle;

  void init(BuildContext context) {
    // if (this.context == null) {
    this.context = context;
    final currenciesService =
        Provider.of<CurrenciesService>(context, listen: false);

    if (stage == CurrentStage.Idle) {
      stage = CurrentStage.WelcomeUser;
      _fetchCurrencies(currenciesService);
    }
    // }
  }

  Future<void> _fetchCurrencies(CurrenciesService currenciesService) async {
    await currenciesService.fetchCurrencies();
    welcomeUser();
  }

  void welcomeUser() {
    _listChildren.remove(loader);
    _listChildren.add(
      Align(
        alignment: Alignment.centerLeft,
        child: Message(
          data:
              "Hey there, welcome to currency tracker app. Click next to continue",
        ),
      ),
    );

    _listChildren.add(Align(
      alignment: Alignment.centerRight,
      child: AppPlatformButton(
        text: 'Next',
        onPressed: () {
          if (stage == CurrentStage.WelcomeUser) showTopCountries();
        },
      ),
    ));
    notifyListeners();
    print("Welcoming user ${listChildren.length}");
  }

  void showTopCountries() {
    stage = CurrentStage.PickTopCountries;
    _listChildren.add(SizedBox(height: 32.0));
    _listChildren.add(
      Align(
        alignment: Alignment.centerLeft,
        child: Message(
          data:
              "Pick from the top currencies to track them and click finish. Click Show more to see all countries",
        ),
      ),
    );
    _listChildren.add(ShowTopCurrencies());
    _listChildren.add(Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppPlatformButton(
            text: 'Finish',
            onPressed: () {
              if (stage == CurrentStage.PickTopCountries) finish();
            },
          ),
          SizedBox(width: 16.0),
          AppPlatformButton(
            text: 'show more',
            onPressed: () {
              if (stage == CurrentStage.PickTopCountries) showAllCountries();
            },
          ),
        ],
      ),
    ));

    notifyListeners();
    scrollToEnd();
  }

  void scrollToEnd() {
    try {
      Future.delayed(Duration(milliseconds: 200)).then((value) =>
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 1500), curve: Curves.easeIn));
    } catch (err) {}
  }

  void showAllCountries() {
    stage = CurrentStage.PickAllCountries;
    _listChildren.add(SizedBox(height: 32.0));
    _listChildren.add(
      Align(
        alignment: Alignment.centerLeft,
        child: Message(
          data: "Pick the currencies to track them and click finish.",
        ),
      ),
    );
    _listChildren.add(ShowAllCurrencies());
    _listChildren.add(Align(
      alignment: Alignment.centerRight,
      child: AppPlatformButton(
        text: 'Finish',
        onPressed: () {
          if (stage == CurrentStage.PickAllCountries) finish();
        },
      ),
    ));
    notifyListeners();
    scrollToEnd();
  }

  void finish() {
    int res  = Provider.of<CurrenciesService>(context, listen: false).saveLocally();
    if(res==-1) {
      Fluttertoast.showToast(msg: "Please select at least 1 currency");
      return;
    }
    Navigator.of(context).pushReplacement(AppNavigation.route(TabsScreen()));
  }

  List<Widget> get listChildren => _listChildren;

  set listChildren(List<Widget> value) {
    _listChildren = value;
    notifyListeners();
  }

  CurrentStage get stage => _stage;

  set stage(CurrentStage value) {
    _stage = value;
    notifyListeners();
  }
}
