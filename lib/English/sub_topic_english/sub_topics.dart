import 'dart:convert';
import 'dart:io';
import 'package:class_9th_ncert_all/DownloadforSubtopic/downloadplatformsubtopic.dart';
import 'package:class_9th_ncert_all/Modals/listdata.dart';
import 'package:class_9th_ncert_all/config/appcolor.dart';
import 'package:class_9th_ncert_all/config/constant.dart';
import 'package:class_9th_ncert_all/pdf%20view/pdf%20view_location.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:path_provider/path_provider.dart';


class SubTopicEnglish extends StatefulWidget {
  final index1;
  final index2;
  final index3;
  final index4;
  final List<String> subtopicDataSet;
  final String topicName;
  const SubTopicEnglish(this.subtopicDataSet, this.index1, this.index2, this.index3,
      this.index4, this.topicName);

  @override
  _SubTopicEnglishState createState() => _SubTopicEnglishState();
}

class _SubTopicEnglishState extends State<SubTopicEnglish> {



  Future<DataSet> loaddataset() async {
  
    String jsonstring =
        await rootBundle.loadString('assets/data_image/Modal.json');
    final jsonresponse = json.decode(jsonstring);
    return DataSet.fromJson(jsonresponse);
  }

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

 

    return FutureBuilder<DataSet>(
        future: loaddataset(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 150,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        Lottie.asset('assets/header/topicwithoutsubtopicenglish.json'),
                    collapseMode: CollapseMode.pin,
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.topicName,
                      ),
                    ),
                  ],
                ),
                SliverList(

                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {

                  return FutureBuilder(
                    future: canviewpdf(index, snapshot.data),
                    builder: (BuildContext context, AsyncSnapshot snapshott) {

                      return snapshott.data != false
                          ? Container(
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
                                        builder: (context) =>
                                            PdfViewLocation(snapshott.data)),
                                  );
    

                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Text(index.toString()),
                                    )),
                                    Flexible(
                                      child: Text(
                                        widget.subtopicDataSet[index].toString(),
                                        style: Theme.of(context)
                                            .accentTextTheme
                                            .headline2,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          deletePdfdata(index, snapshott.data);
                                        },
                                        icon:
                                            Icon(Icons.delete_outline_outlined))
                                  ],
                                ),
                              ),
                            )
                              : Container(
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
                                  child: GestureDetector(
                                    onTap: () async {

                 
                                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                           DownloadPlatformSubtopic(index, snapshot.data, widget.index1,widget.index2,widget.index3,widget.index4,'en')),
                                ).then((value){

                                  setState(() {
                                    print('================================Reload==================================');
                                    
                                  });
                                });
                                      
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            child: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          child: Text(index.toString()),
                                        )),
                                        Flexible(
                                          child: Text(
                                            widget.subtopicDataSet[index]
                                                .toString(),
                                            style: Theme.of(context)
                                                .accentTextTheme
                                                .headline2,
                                          ),
                                        ),
                                        Icon(
                                            Icons.download_for_offline_outlined)
                                      ],
                                    ),


                                  ),
                                );










                    },
                  );
                }, childCount: widget.subtopicDataSet.length))
              ],
            ),
          ));
        });
  }

  

  deletePdfdata(index, File file) {
    if (file.existsSync()) {
      file.deleteSync();
      setState(() {});
    }
  }

  Future canviewpdf(int index, DataSet dataSet) async {
       String language='en';

    final bookname = dataSet.bookDataSet[widget.index1].bookName;
    final subjectname = dataSet
        .bookDataSet[widget.index1].subjectDataSet[widget.index2].subjectName;
    final booksolutionname = dataSet
        .bookDataSet[widget.index1]
        .subjectDataSet[widget.index2]
        .bookSolutionDataSet[widget.index3]
        .booksolutionname;
    final topicname = dataSet
        .bookDataSet[widget.index1]
        .subjectDataSet[widget.index2]
        .bookSolutionDataSet[widget.index3]
        .topicDataset[widget.index4]
        .topicName;
    final subtopicname = dataSet
        .bookDataSet[widget.index1]
        .subjectDataSet[widget.index2]
        .bookSolutionDataSet[widget.index3]
        .topicDataset[widget.index4]
        .subtopicDataSet[index];

    String filename =
        '${bookname}_${subjectname}_${booksolutionname}_${topicname}_${subtopicname}_$language' +
            '.pdf';

    Directory dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');

    if (file.existsSync()) {
      return file;
    } 
    else {
      return false;
    }
  }





}
