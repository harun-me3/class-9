import 'dart:io';
import 'package:class_9th_ncert_all/Modals/listdata.dart';
import 'package:class_9th_ncert_all/config/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class DownloadPlatformSubtopic extends StatefulWidget {
  final int index;
  final DataSet dataSet;
  final index1;
  final index2;
  final index3;
  final index4;
  final String language;

  const DownloadPlatformSubtopic(this.index, this.dataSet, this.index1, this.index2,
      this.index3,this.index4,this.language);

  @override
  _DownloadPlatformSubtopicState createState() => _DownloadPlatformSubtopicState();
}

class _DownloadPlatformSubtopicState extends State<DownloadPlatformSubtopic> {
  @override
  void initState() {
    super.initState();
    downloadpdfdata(widget.index, widget.dataSet, widget.language);
  }


  @override
  void dispose() {
        if (task!= null) {
            task!.cancel().then((value) => {
                 print('================================task cancel ==================================')
            });
          }
    super.dispose();
  }

  DownloadTask? task;
  File? file;

  double _percenatge = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200.0),
          child: AppBar(
            flexibleSpace: Container(
              child: Lottie.asset(
                  'assets/header/Downloadplatform.json'),
            ),
            elevation: 0.0,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: kDefaultPadding * 4,
          margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 3),
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: LiquidLinearProgressIndicator(
            borderRadius: 20.0,
            value: _percenatge / 100,
            valueColor: AlwaysStoppedAnimation(Colors.amber),
            center: Text(
              '${_percenatge.abs().toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            direction: Axis.horizontal,
            backgroundColor: Colors.grey.shade300,
          ),
        ),
      ),
      onWillPop: () async {
        if (_percenatge == 100) {
          print( '================================task completed 100%==================================');
          Navigator.of(context).pop(false);
        } else {
         

           if (task!= null) {
            task!.cancel().then((value) => {
                 print('================================task cancel ==================================')
            });
          }
          if (file != null) {
            deletePdfdata(file!);
               print('================================file deleted ==================================');
          }
         _percenatge = 0;
          Navigator.of(context).pop(false);
        }
        return false;
      },
    );
  }

  deletePdfdata(File file) {
    if (file.existsSync()) {
      file.deleteSync();

    }
  }

  void downloadpdfdata(index, DataSet dataSet, String language) async {
    print(
        '========================================Love Hindi==================================================');

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

    final String pathofdata = 
        '$bookname/$subjectname/$booksolutionname/$topicname/$subtopicname/$language/';



    String filename =
        '${bookname}_${subjectname}_${booksolutionname}_${topicname}_${subtopicname}_$language';

    final ref = await FirebaseStorage.instance.ref(pathofdata).listAll();

    ref.items.forEach((e) {
      filename = filename + '.pdf';
      writefile(e, filename, index);
    });
  }

  writefile(Reference ref, String filename, index) async {
    final dir = await getApplicationDocumentsDirectory();

    this.file = File('${dir.path}/$filename');

    this.task = ref.writeToFile(file!);

    task!.snapshotEvents.listen((snapshot) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      setState(() {
        _percenatge = ((snapshot.bytesTransferred / snapshot.totalBytes) * 100);
      });
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(task!.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    task!.whenComplete(() => {
          _percenatge = 0,
          print(
              '================================task completed=================================='),
          Navigator.of(context).pop(false),
        });
  }
}
