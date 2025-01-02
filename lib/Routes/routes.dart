import 'package:flutter/material.dart';

import '../screens/aarti_screen/aarti_details.dart';
import '../screens/aarti_screen/aarti_home.dart';
import '../screens/bhagwag_geets_screen/bhagwad_details.dart';
import '../screens/bhagwag_geets_screen/bhagwad_full_details.dart';
import '../screens/bhagwag_geets_screen/bhagwad_geets_home.dart';
import '../screens/favorite_screen/favorite_page.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/settings_screen/settings_page.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../screens/suvichar_screen/suvichar_page.dart';

class Router {
  static MaterialPageRoute onRouteGenerator(settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SplashScreen(),
        );

      case HomePage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );

      case AartiHome.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AartiHome(
            title: settings.arguments,
          ),
        );

      case AartiDetails.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AartiDetails(),
        );

      case SuvicharPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SuvicharPage(),
        );

      case BhagavadGeetaHome.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BhagavadGeetaHome(),
        );

      case BhagwadDetails.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BhagwadDetails(),
        );

      case SettingsPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SettingsPage(),
        );

      case BhagwadFullDetails.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BhagwadFullDetails(),
        );

      case FavoritePage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => FavoritePage(),
        );

      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Material(
            child: Center(
              child: Text("404 page not founded"),
            ),
          ),
        );
    }
  }
}
