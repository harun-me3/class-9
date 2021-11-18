import 'package:class_9th_ncert_all/langauge/langauge_provider.dart';
import 'package:class_9th_ncert_all/notificationlist/forgroundpushmessage.dart';
import 'package:class_9th_ncert_all/splashScreen/splashScreen.dart';
import 'package:class_9th_ncert_all/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//  background but opened but it work without tap
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //=============================================================================================
  //firebase messaging

  await Firebase.initializeApp();

//=============================================================================================
// theme toggle

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  final themebox = await Hive.openBox('themebox');

  bool isLightTheme = themebox.get('isLightTheme') ?? false;

//=============================================================================================
  //langauge toggle

  final languagebox = await Hive.openBox('languagebox');

  bool isHindi = languagebox.get('isHindi') ?? false;

//=============================================================================================
// localization hindi to english and English to Hindi
  await EasyLocalization.ensureInitialized();

//=============================================================================================
//Receive message when app is in background but opened but it work without tap
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // mode

  return runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('hi')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiProvider(providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(isLightTheme)),
        ChangeNotifierProvider<LangaugeProvider>(
            create: (context) => LangaugeProvider(isHindi)),
      ], child: NcertHome()),
    ),
  );
}

class NcertHome extends StatefulWidget {
  const NcertHome({Key? key}) : super(key: key);

  @override
  _NcertHomeState createState() => _NcertHomeState();
}

class _NcertHomeState extends State<NcertHome> {
  @override
  void initState() {
    super.initState();
    ForgroundPushMessage.initialize(context);

//gives you the message on which user taps and it opened the app from terminated(closed) state
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((message) => {print(message!.notification!.title)});

    //=============================================================================================
    //flutter local notification intialize

    //forground work when we are using Appp
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        ForgroundPushMessage.display(message);
      }
    });

    //When the app is in background but opened and user taps on the notification

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        print(notification.title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LangaugeProvider>(
        builder: (context, themeProvider, langaugeProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeProvider.themeData(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: SplashScreen(),
      );
    });
  }
}
