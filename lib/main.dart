import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mypersonalconcierge/screens/login_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mypersonalconcierge/utils/analyticsutil.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        Provider<AnalyticsUtils>(
          create: (_) => AnalyticsUtils(analytics),
        ),
      ],
      child: MaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}