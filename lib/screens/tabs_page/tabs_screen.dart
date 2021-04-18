import 'package:currency_tracker/screens/tabs_page/tabs_controller.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TabsController>.reactive(
      onModelReady: (m) => {},
      viewModelBuilder: () => TabsController(),
      builder: (context, controller, child) => Scaffold(
        body: controller.screens[controller.currentScreen],
        bottomNavigationBar: BottomNavigationBar(
           currentIndex: controller.currentScreen,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.track_changes),
              title: Text('Track'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],

          onTap: (int i) {
            controller.currentScreen = i;
          },
        ),
      ),
    );
  }
}
