import 'dart:ui';
import 'package:class_9th_ncert_all/config/appcolor.dart';
import 'package:class_9th_ncert_all/config/constant.dart';
import 'package:class_9th_ncert_all/downloadedBook/downloadedbook.dart';
import 'package:class_9th_ncert_all/langauge/langauge_provider.dart';
import 'package:class_9th_ncert_all/launcher_config/launcher.dart';
import 'package:class_9th_ncert_all/notificationlist/pushmessage.dart';
import 'package:class_9th_ncert_all/privacy_policy/privacypolicy.dart';
import 'package:class_9th_ncert_all/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // actual store listing review & rating
  void _rateAndReviewApp() async {
    final _inAppReview = InAppReview.instance;

    if (await _inAppReview.isAvailable()) {
      print('request actual review from store');
      _inAppReview.requestReview();
    } else {
      print('open actual store listing');
      _inAppReview.openStoreListing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.orange,
      padding: EdgeInsets.only(top: 50, bottom: 30, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Lottie.asset('assets/header/drawerheader.json'),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'app_name1',
                    style: Theme.of(context).accentTextTheme.headline4,
                  ).tr(),
                  Text(
                    'app_name2',
                    style: Theme.of(context).accentTextTheme.headline4,
                  ).tr(),
                  Text(
                    'class',
                    style: Theme.of(context).accentTextTheme.headline4,
                  ).tr()
                ],
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 0.0,
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    children: <Widget>[
//...bottom card part,
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 66 + 16,
                                          bottom: 16,
                                          left: 16,
                                          right: 16,
                                        ),
                                        margin: EdgeInsets.only(top: 66),
                                        decoration: new BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10.0,
                                              offset: const Offset(0.0, 10.0),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize
                                              .min, // To make the card compact
                                          children: <Widget>[
                                            Text(
                                              'Theme toggle',
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .headline1,
                                            ),
                                            SizedBox(height: 24.0),
                                            FlutterSwitch(
                                              width: 90.0,
                                              height: 50.0,
                                              toggleSize: 43.0,
                                              value: Provider.of<ThemeProvider>(
                                                          context)
                                                      .isLightTheme
                                                  ? true
                                                  : false,
                                              borderRadius: 30.0,
                                              padding: 1.5,
                                              activeToggleColor:
                                                  Color(0xFF6E40C9),
                                              inactiveToggleColor:
                                                  Color(0xFF2F363D),
                                              activeSwitchBorder: Border.all(
                                                color: Color(0xFF3C1E70),
                                                width: 6.0,
                                              ),
                                              inactiveSwitchBorder: Border.all(
                                                color: Color(0xFFD1D5DA),
                                                width: 6.0,
                                              ),
                                              activeColor: Color(0xFF271052),
                                              inactiveColor: Colors.white,
                                              activeIcon: Icon(
                                                Icons.nightlight_round,
                                                color: Color(0xFFF8E3A1),
                                              ),
                                              inactiveIcon: Icon(
                                                Icons.wb_sunny,
                                                color: Color(0xFFFFDF5D),
                                              ),
                                              onToggle: (value) {
                                                Provider.of<ThemeProvider>(
                                                        context,
                                                        listen: false)
                                                    .toggleThemeData();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),

//...top circlular image part,
                                      Positioned(
                                        left: 12,
                                        right: 12,
                                        child: CircleAvatar(
                                          child: Lottie.asset(
                                              'assets/header/darkmode.json'),
                                          radius: 55,
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.dark_mode_outlined,
                        size: iconsize,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'theme_changer',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ).tr()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 0.0,
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    children: <Widget>[
//...bottom card part,
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 66 + 16,
                                          bottom: 16,
                                          left: 16,
                                          right: 16,
                                        ),
                                        margin: EdgeInsets.only(top: 66),
                                        decoration: new BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10.0,
                                              offset: const Offset(0.0, 10.0),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize
                                              .min, // To make the card compact
                                          children: <Widget>[
                                            Text(
                                              'Langauge toggle',
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .headline1,
                                            ),
                                            SizedBox(height: 24.0),
                                            FlutterSwitch(
                                              width: 90.0,
                                              height: 50.0,
                                              toggleSize: 43.0,
                                              value:
                                                  Provider.of<LangaugeProvider>(
                                                              context)
                                                          .isHindi
                                                      ? true
                                                      : false,
                                              borderRadius: 30.0,
                                              padding: 1.5,
                                              activeToggleColor:
                                                  Color(0xFF6E40C9),
                                              inactiveToggleColor:
                                                  Color(0xFF6E40C9),
                                              activeSwitchBorder: Border.all(
                                                color: Color(0xFF3C1E70),
                                                width: 6.0,
                                              ),
                                              inactiveSwitchBorder: Border.all(
                                                color: AppColor.orange,
                                                width: 6.0,
                                              ),
                                              activeColor: AppColor.orange,
                                              inactiveColor: Colors.white,
                                              activeIcon: Image.asset(
                                                  'assets/header/india.png'),
                                              inactiveIcon: Image.asset(
                                                  'assets/header/uk.png'),
                                              onToggle: (value) {
                                                print(
                                                    '====================$value');

                                                Provider.of<LangaugeProvider>(
                                                        context,
                                                        listen: false)
                                                    .toggleLangauge();

                                                value == true
                                                    ? context
                                                        .setLocale(Locale('hi'))
                                                    : context.setLocale(
                                                        Locale('en'));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),

//...top circlular image part,
                                      Positioned(
                                        left: 12,
                                        right: 12,
                                        child: CircleAvatar(
                                          child: Lottie.asset(
                                              'assets/header/langauge.json'),
                                          radius: 66,
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.translate,
                        size: iconsize,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'langauge_changer',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ).tr()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PushMessagePage(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_active_outlined,
                        size: iconsize,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'notification',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ).tr()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Utils.openEmail(
                      toEmail: 'rahulguptasonu123@gmail.com',
                      subject: 'correction in App Content',
                      body: '''Please Send correction in this format
Book_Name:______
Subject_Name:______
Topic_Name:______
Subtopic_Name(Optional):______
Question or Answer:______
ScreenShot(Optional):______
                       ''',
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.mail_outline_outlined,
                        size: iconsize,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'correction',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ).tr()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DownloadedBook(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.download_done_outlined,
                        size: iconsize,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'downloded_book',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ).tr()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Utils.openLink(
                        url:
                            'https://play.google.com/store/apps/developer?id=TRV+Team');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.more_outlined,
                        size: iconsize,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'more_app',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ).tr(),

                      SizedBox(
                        width: 5,
                      ),

                      //Uncomment on when adbmob is implemented

                      // Container(
                      //   padding: EdgeInsets.only(left: 4.0, right: 4.0),
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: Text(
                      //     'Ad',
                      //     style: TextStyle(
                      //       fontSize: 8.0
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    Share.share(
                        'https://play.google.com/store/apps/details?id=com.trv.ncertclass9th',
                        subject:
                            "For NCERT Solution install this App from Play store");
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        size: iconsize,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'share_app',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ).tr()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, setState) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 0.0,
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    children: <Widget>[
//...bottom card part,
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 66 + 16,
                                          bottom: 16,
                                          left: 16,
                                          right: 16,
                                        ),
                                        margin: EdgeInsets.only(top: 66),
                                        decoration: new BoxDecoration(
                                          color: Theme.of(context).accentColor,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 10.0,
                                              offset: const Offset(0.0, 10.0),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize
                                              .min, // To make the card compact
                                          children: <Widget>[
                                            RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                    style: Theme.of(context)
                                                        .accentTextTheme
                                                        .bodyText1,
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              'Thanks for rating\n',
                                                          style: Theme.of(
                                                                  context)
                                                              .accentTextTheme
                                                              .headline1,
                                                          children: [
                                                            TextSpan(
                                                              text:
                                                                  'If you learned something from this platfrom please rate us good',
                                                              style: Theme.of(
                                                                      context)
                                                                  .accentTextTheme
                                                                  .headline2,
                                                            )
                                                          ]),
                                                    ])),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: AppColor.orange,
                                              ),
                                              onRatingUpdate: (ratingvalue) {
                                                if (ratingvalue == 5.0 ||
                                                    ratingvalue == 4.0)
                                                  _rateAndReviewApp();
                                              },
                                            )
                                          ],
                                        ),
                                      ),

//...top circlular image part,
                                      Positioned(
                                        left: 12,
                                        right: 12,
                                        child: CircleAvatar(
                                          child: Lottie.asset(
                                              'assets/header/star.json'),
                                          radius: 55,
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border_outlined,
                        size: iconsize,
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'rate_us',
                        style: Theme.of(context).accentTextTheme.headline4,
                      ).tr()
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.lock_outlined,
                size: iconsize,
                color: Color(0xFFFFFFFF),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicy(),
                    ),
                  );
                },
                child: Text(
                  'privacy_policy',
                  style: Theme.of(context).accentTextTheme.headline4,
                ).tr(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
