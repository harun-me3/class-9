import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewDistractionFreeMode extends StatefulWidget {
  final File file;
  PdfViewDistractionFreeMode(this.file);

  @override
  _PdfViewDistractionFreeModeState createState() =>
      _PdfViewDistractionFreeModeState();
}

class _PdfViewDistractionFreeModeState
    extends State<PdfViewDistractionFreeMode> {
  late final PdfViewerController _pdfViewerController;

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SfPdfViewer.file(
            widget.file,
            controller: _pdfViewerController,
            key: _pdfViewerKey,
          ),
        ),
      ),
    );
  }
}
