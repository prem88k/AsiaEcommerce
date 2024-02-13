import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pocketuse/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Providers/CartCountProvider.dart';
import 'Utils/Consts.dart';

//void main() => runApp(MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GlobalConfiguration().loadFromAsset("configurations");
//  runApp(MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartCountProvider()),
        // ignore: missing_required_param
//        ChangeNotifierProxyProvider<CartCountProvider,CartCountProvider>(
//          create: (context) => CartCountProvider(),
//        ),
//        Provider(create: (context) => SomeOtherClass()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
//    requestPermission();

    return new MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate,
//        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ar')
      ],
      navigatorKey: Consts.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: Consts.app_name,
      theme: new ThemeData(
//          appBarTheme: Theme.of(context)
//              .appBarTheme
//              .copyWith(brightness: Brightness.light, color:Consts.app_primary_color),
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent,
          hintColor: Colors.black87,
          inputDecorationTheme: new InputDecorationTheme(
              labelStyle: new TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0)))
      ),

//      home: new SplashPage(),

      initialRoute: '/SplashPage', // default is '/'
      onGenerateRoute: RouteGenerator.generateRoute,

    );

  }
}


