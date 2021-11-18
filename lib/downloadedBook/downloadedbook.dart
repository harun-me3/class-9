import 'dart:io';
import 'package:class_9th_ncert_all/config/appcolor.dart';
import 'package:class_9th_ncert_all/config/constant.dart';
import 'package:class_9th_ncert_all/pdf%20view/pdf%20view_location.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:path_provider/path_provider.dart';

class DownloadedBook extends StatelessWidget {
  DownloadedBook({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: fileoperation(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(
                  top: 32.0
                ),
                child: CustomScrollView(
                  
            physics: BouncingScrollPhysics(),
            slivers: [

            
                SliverAppBar(
                 pinned: true,
                  expandedHeight: 150,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Lottie.asset('assets/header/downloadedbook.json',
                                  
                    ),
                    collapseMode: CollapseMode.pin,
       
                  ),

                
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                 
                  ), 
                      actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Downloaded',
          ),
            ),

          ],
                ),





                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  File file = new File(snapshot.data![index]);
                  List<String> name = file.path.split('/').last.split('_');

                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 3),
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                      vertical: kDefaultPadding,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PdfViewLocation(file)),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(index.toString()),
                          )),
                          Flexible(
                            child: Text(
                              '${name[0]}>${name[1]}>${name[3]}',
                              textAlign: TextAlign.center,
                                   style: Theme.of(context).accentTextTheme.headline2,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: name[2].split(' ').last.trim() == 'Book'
                                  ? Icon(Icons.menu_book)
                                  : Icon(Icons.border_color))
                        ],
                      ),
                    ),
                  );
                }, childCount: snapshot.data!.length))
            ],
          ),
              ));
        });
  }

  Future<List<String>> fileoperation() async {
    Directory dir = await getApplicationDocumentsDirectory();

    var listofpdf = dir
        .listSync()
        .map((item) => item.path)
        .where((element) => element.endsWith('.pdf'))
        .toList();

    return listofpdf;
  }
}
