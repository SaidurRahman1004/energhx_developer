import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CertificateService {
  CertificateService._();

  /// Generates a professional PDF certificate and saves it to the device storage.
  /// Returns the saved file path.
  static Future<String> generateAndSaveCertificate({
    required String studentName,
    required String programTitle,
  }) async {
    final pdf = pw.Document();

    final dateStr = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    const certId = 'ENX-2026-DEV-89412';

    // Page format landscape A4
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: const PdfColor.fromInt(0xFF2DAD00),
                width: 3,
              ),
              borderRadius: pw.BorderRadius.circular(12),
            ),
            padding: const pw.EdgeInsets.all(16),
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: const PdfColor.fromInt(0xFFCBD5E1),
                  width: 1,
                ),
                color: const PdfColor.fromInt(0xFFFAFCFA),
              ),
              padding: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  // Header
                  pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'ENERGHX DEVELOPER',
                            style: pw.TextStyle(
                              color: const PdfColor.fromInt(0xFF2DAD00),
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          pw.Text(
                            'ID: $certId',
                            style: const pw.TextStyle(
                              color: PdfColor.fromInt(0xFF64748B),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 12),
                      pw.Text(
                        'CERTIFICATE OF COMPLETION',
                        style: pw.TextStyle(
                          color: const PdfColor.fromInt(0xFF0F172A),
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Container(
                        width: 80,
                        height: 2,
                        color: const PdfColor.fromInt(0xFF2DAD00),
                      ),
                    ],
                  ),

                  // Body
                  pw.Column(
                    children: [
                      pw.Text(
                        'This is to certify that',
                        style: const pw.TextStyle(
                          color: PdfColor.fromInt(0xFF64748B),
                          fontSize: 13,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        studentName,
                        style: pw.TextStyle(
                          color: const PdfColor.fromInt(0xFF0F172A),
                          fontSize: 26,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        'has successfully met all curriculum requirements and completed the professional program in',
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(
                          color: PdfColor.fromInt(0xFF475569),
                          fontSize: 12,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        decoration: pw.BoxDecoration(
                          color: const PdfColor.fromInt(0xFFEDF9F1),
                          borderRadius: pw.BorderRadius.circular(6),
                          border: pw.Border.all(
                            color: const PdfColor.fromInt(0xFFBCE7C6),
                          ),
                        ),
                        child: pw.Text(
                          programTitle,
                          style: pw.TextStyle(
                            color: const PdfColor.fromInt(0xFF2DAD00),
                            fontSize: 15,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Footer: Date, Signatures & Seal
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      // Date
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            dateStr,
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 11,
                              color: const PdfColor.fromInt(0xFF1E293B),
                            ),
                          ),
                          pw.Container(
                            margin: const pw.EdgeInsets.only(top: 4),
                            width: 120,
                            height: 1,
                            color: const PdfColor.fromInt(0xFF94A3B8),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            'Date of Issue',
                            style: const pw.TextStyle(
                              color: PdfColor.fromInt(0xFF64748B),
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),

                      // Verified Badge
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          border: pw.Border.all(
                            color: const PdfColor.fromInt(0xFF2DAD00),
                            width: 2,
                          ),
                          color: const PdfColor.fromInt(0xFFF0FDF4),
                        ),
                        child: pw.Column(
                          mainAxisSize: pw.MainAxisSize.min,
                          children: [
                            pw.Text(
                              'VERIFIED',
                              style: pw.TextStyle(
                                color: const PdfColor.fromInt(0xFF2DAD00),
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              'ENERGHX',
                              style: pw.TextStyle(
                                color: const PdfColor.fromInt(0xFF0F172A),
                                fontSize: 7,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Instructor Signature
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            'Dr. Marcus Vance',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 11,
                              color: const PdfColor.fromInt(0xFF1E293B),
                            ),
                          ),
                          pw.Container(
                            margin: const pw.EdgeInsets.only(top: 4),
                            width: 130,
                            height: 1,
                            color: const PdfColor.fromInt(0xFF94A3B8),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text(
                            'Director of Engineering',
                            style: const pw.TextStyle(
                              color: PdfColor.fromInt(0xFF64748B),
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    // Save to device storage
    final bytes = await pdf.save();

    final fileName =
        'Energhx_${programTitle.replaceAll(RegExp(r'\s+'), '_')}_Certificate.pdf';

    String targetPath = '';

    try {
      // 1. Try public Download folder on Android if accessible
      if (Platform.isAndroid) {
        final downloadDir = Directory('/storage/emulated/0/Download');
        if (await downloadDir.exists()) {
          targetPath = '${downloadDir.path}/$fileName';
        }
      }

      // 2. Try getDownloadsDirectory or getApplicationDocumentsDirectory
      if (targetPath.isEmpty) {
        final dir = await getDownloadsDirectory() ??
            await getApplicationDocumentsDirectory();
        targetPath = '${dir.path}/$fileName';
      }

      final file = File(targetPath);
      await file.writeAsBytes(bytes, flush: true);
      debugPrint('[CertificateService] Certificate saved to: $targetPath');
      return targetPath;
    } catch (e) {
      debugPrint('[CertificateService] Error saving to primary location: $e');
      final fallbackDir = await getApplicationDocumentsDirectory();
      final fallbackPath = '${fallbackDir.path}/$fileName';
      final file = File(fallbackPath);
      await file.writeAsBytes(bytes, flush: true);
      return fallbackPath;
    }
  }

  /// Opens the saved certificate file in the native PDF viewer safely.
  static Future<void> openCertificate(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final result = await OpenFilex.open(filePath);
        debugPrint('[CertificateService] OpenFilex result: ${result.message}');
      }
    } catch (e) {
      debugPrint('[CertificateService] Handled open certificate info: $e');
    }
  }
}
