import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:vcu/widgets/cta_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;





class ViewPdf extends StatefulWidget {  
  const ViewPdf({Key? key,required this.file, required this.docname}) : super(key: key);
  final File file;
  final String docname;

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final name = widget.docname;

    return Scaffold(
      appBar: CtaAppbar(screenname: name,),
      body: PDFView(


        autoSpacing: false,
        pageFling: true,
        pageSnap: true,
        filePath: widget.file.path,
      ),
    );
  }
}
