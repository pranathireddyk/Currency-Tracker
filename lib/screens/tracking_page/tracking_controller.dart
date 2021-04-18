import 'package:currency_tracker/services/api.dart';
import 'package:currency_tracker/services/currencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

enum ViewStatus { Loading, Loaded }

class TrackingController extends ChangeNotifier {
  BuildContext _context;

  ViewStatus _status = ViewStatus.Loading;

  void init(BuildContext context) {
    _context = context;
    loadForFirstTime();
  }

  Future<void> loadForFirstTime() async {
    Provider.of<CurrenciesService>(_context, listen: false).refresh();
    await Future.delayed(Duration(seconds: 3));
    status = ViewStatus.Loaded;
    Stream.periodic(Duration(seconds: APIService.refreshTime)).listen(
      (event) {
        try {
          print("refreshing after ${APIService.refreshTime} seconds");
          Provider.of<CurrenciesService>(_context, listen: false).refresh();
        } catch (err) {
          // widget was disposed
        }
      },
    );
  }

  ViewStatus get status => _status;

  set status(ViewStatus value) {
    _status = value;
    notifyListeners();
  }
}
