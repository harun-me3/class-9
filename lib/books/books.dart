import 'package:class_9th_ncert_all/Modals/listdata.dart';
import 'package:class_9th_ncert_all/QandA/QAhome/qahome.dart';
import 'package:class_9th_ncert_all/config/appcolor.dart';
import 'package:class_9th_ncert_all/config/constant.dart';
import 'package:class_9th_ncert_all/langauge/langauge_provider.dart';

import 'package:class_9th_ncert_all/subject/subjects.dart';
import 'package:class_9th_ncert_all/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Books extends StatefulWidget {
  final zoomDrawerController;
  const Books(this.zoomDrawerController);

  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataSet>(
      future: Provider.of<LangaugeProvider>(context)
          .loadJsonDataSet(), // async work
      builder: (BuildContext context, AsyncSnapshot<DataSet> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading....');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QAhome()),
                          );
                        },
                        child: Icon(
                          Icons.album,
                          size: 48.0,
                        ),
                      ),
                    ),
                    FlutterSwitch(
                      width: 90.0,
                      height: 50.0,
                      toggleSize: 43.0,
                      value: Provider.of<LangaugeProvider>(context).isHindi
                          ? true
                          : false,
                      borderRadius: 30.0,
                      padding: 1.5,
                      activeToggleColor: Color(0xFF6E40C9),
                      inactiveToggleColor: Color(0xFF6E40C9),
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
                      activeIcon: Image.asset('assets/header/india.png'),
                      inactiveIcon: Image.asset('assets/header/uk.png'),
                      onToggle: (value) {
                        print('====================$value');

                        Provider.of<LangaugeProvider>(context, listen: false)
                            .toggleLangauge();
                        CircularProgressIndicator();

                        value == true
                            ? context.setLocale(Locale('hi'))
                            : context.setLocale(Locale('en'));
                      },
                    )
                  ],
                ),
                body: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Lottie.asset(
                          'assets/header/books.json',
                        ),
                      ),
                      snap: true,
                      pinned: true,
                      floating: true,
                      elevation: 5,
                      expandedHeight: 150,
                      leading: IconButton(
                        icon: Icon(Icons.menu),
                        tooltip: 'Menu',
                        onPressed: () => widget.zoomDrawerController.toggle(),
                      ), //IconButton

                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'books',
                          ).tr(),
                        ),
                      ],
                    ),
                    SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          Size size = MediaQuery.of(context).size;
                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding / 2,
                              vertical: kDefaultPadding / 3,
                            ),
                            height: 160,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Subject(
                                          snapshot.data!.bookDataSet[index]
                                              .subjectDataSet,
                                          index,
                                          snapshot.data!.bookDataSet[index]
                                              .bookName)),
                                );
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  // Those are our background
                                  Container(
                                    height: 136,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: index.isEven
                                          ? kBlueColor
                                          : kSecondaryColor,
                                      boxShadow: [kDefaultShadow],
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                    .isLightTheme
                                                ? Color(0xFF3A3B3C)
                                                : Color(0xFFFFFFFF),
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                    ),
                                  ),

                                  // our product image
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding),
                                      height: 88,
                                      // image is square but we add extra 20 + 20 padding thats why width is 128
                                      width: 128,
                                      child: Image.asset(
                                        snapshot.data!.bookDataSet[index]
                                            .bookImageSrc,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  // Product title and price
                                  Positioned(
                                    top: -20,
                                    left: 0,
                                    child: SizedBox(
                                      height: 160,
                                      // our image take 200 width, thats why we set out total width - 200
                                      width: size.width - 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: kDefaultPadding),
                                            child: Text(
                                              snapshot.data!.bookDataSet[index]
                                                  .bookName,
                                              style: Theme.of(context)
                                                  .accentTextTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }, childCount: snapshot.data!.bookDataSet.length),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width / 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        )),
                  ],
                ),
              );
        }
      },
    );
  }
}
