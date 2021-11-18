import 'dart:io';
import 'dart:typed_data';
import 'package:class_9th_ncert_all/launcher_config/launcher.dart';
import 'package:class_9th_ncert_all/pdf%20view/pdfviewdistractionfreemode.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/services.dart';

class PdfViewLocation extends StatefulWidget {
  final File file;
  const PdfViewLocation(this.file);

  @override
  _PdfViewLocationState createState() => _PdfViewLocationState();
}

class _PdfViewLocationState extends State<PdfViewLocation> {
 final PdfViewerController _pdfViewerController=PdfViewerController();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  


  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        appBar:AppBar(
        
          title: Text('Pdf'),
          actions: <Widget>[

            IconButton(
              icon: Icon(
                Icons.crop_free_outlined,
               
              ),
              onPressed: () {
               Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>PdfViewDistractionFreeMode(widget.file)),
                        ); 
              },
            ),
            Theme(
              data: Theme.of(context).copyWith(
               cardColor: Theme.of(context).accentColor,
              iconTheme:  Theme.of(context).iconTheme,
              
              ),
              child: PopupMenuButton<int>(
                
                elevation: 5,
                
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: GestureDetector(
                      onTap: () async {
                        final image = await controller.capture();
                        saveandshare(image);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.screenshot_outlined,
                       
                          ),
                          const SizedBox(width: 8),
                          Text('Share ScreenShot', style: Theme.of(context).accentTextTheme.headline2,
                           
                          ),
                        ],
                      ),
                    ),
                  ),
              
               
                  PopupMenuItem<int>(
                    value: 1,
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
                          Icon(Icons.forward_to_inbox_outlined,
                        
                          ),
                          const SizedBox(width: 8),
                          Text('Report for correction',
                          style: Theme.of(context).accentTextTheme.headline2
                          ),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: GestureDetector(
                      onTap: () {
                        MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? SystemChrome.setPreferredOrientations(
                                [DeviceOrientation.landscapeRight])
                            : SystemChrome.setPreferredOrientations(
                                [DeviceOrientation.portraitUp]);

                      },
                      child: Row(
                        children: [
                          MediaQuery.of(context).orientation ==
                                Orientation.portrait?Icon(Icons.stay_primary_landscape_outlined,):Icon(Icons.stay_primary_portrait_outlined),
                          const SizedBox(width: 8),
                          MediaQuery.of(context).orientation ==
                                Orientation.portrait?Text('Landscape',
                                style: Theme.of(context).accentTextTheme.headline2
                                ):Text('Portrait',
                                style: Theme.of(context).accentTextTheme.headline2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),












        
        body: SafeArea(
          child: Screenshot(
            controller: controller,
            child: Container(
              child: SfPdfViewer.file(
                widget.file,
                controller: _pdfViewerController,
                key: _pdfViewerKey,
                
              ),
            ),
          ),
        ));    
    
  }


  void saveandshare(Uint8List? bytes) async {
    final directory = await getApplicationDocumentsDirectory();

    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes!);
    await Share.shareFiles([image.path]);
  }
}
