
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfHelper {
  PdfHelper._();

  /// ✅ যেকোনো screen এ use করো
  static Widget buildPdfViewer({
    required String pdfUrl,
    double heightFactor = 0.45,
  }) {
    if (pdfUrl.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final pdfHeight = MediaQuery.of(context).size.height * heightFactor;
        return SizedBox(
          height: pdfHeight,
          width: double.infinity,
          child: SfPdfViewer.network(pdfUrl),
        );
      },
    );
  }
}