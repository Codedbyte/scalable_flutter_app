import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scalable_flutter_app/locator.dart';
import 'package:scalable_flutter_app/providers/authenticationprovider.dart';
import 'screens/authentication/splashscreen.dart';
import 'services/navigation/navigationservice.dart';
import 'services/navigation/router.dart';

void main(){
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthenticationProvider>(
              create: (BuildContext context) => locator<AuthenticationProvider>()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
        navigatorKey: locator<NavigationService>().navigationKey,
        home: SplashScreen(),
      ),
    );
  }
}
