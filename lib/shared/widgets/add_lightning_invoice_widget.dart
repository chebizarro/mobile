import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mostro_mobile/core/app_theme.dart';
import 'package:mostro_mobile/shared/widgets/clickable_amount_widget.dart';
import 'package:mostro_mobile/shared/widgets/scanner_error_widget.dart';

class AddLightningInvoiceWidget extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final int amount;

  const AddLightningInvoiceWidget({
    super.key,
    required this.controller,
    required this.onSubmit,
    required this.onCancel,
    required this.amount,
  });

  @override
  State<AddLightningInvoiceWidget> createState() =>
      _AddLightningInvoiceWidgetState();
}

class _AddLightningInvoiceWidgetState extends State<AddLightningInvoiceWidget> {
  final MobileScannerController scannerController = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  @override
  Widget build(BuildContext context) {
    // Define a scan window (centered in the scanner container)
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset(-40, -230)),
      width: 200,
      height: 200,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Camera preview area at the top.
        SizedBox(
          height: 250,
          child: Stack(
            fit: StackFit.expand,
            children: [
              MobileScanner(
                fit: BoxFit.contain,
                controller: scannerController,
                scanWindow: scanWindow,
                onDetect: (barcode) {
                  final String? code = barcode.barcodes[0].rawValue;
                  if (code != null && code.isNotEmpty) {
                    setState(() {
                      widget.controller.text = code;
                    });
                  }
                },
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
              ),
              ValueListenableBuilder(
                valueListenable: scannerController,
                builder: (context, value, child) {
                  return CustomPaint(
                    painter: ScannerOverlay(scanWindow: scanWindow),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // The amount text widget.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ClickableAmountText(
            leftText: 'Please enter a Lightning Invoice for: ',
            amount: '${widget.amount}',
            rightText: ' sats',
          ),
        ),
        const SizedBox(height: 16),
        // The text field for entering (or auto-filling) the invoice.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
            key: const Key('invoiceTextField'),
            controller: widget.controller,
            style: const TextStyle(color: AppTheme.cream1),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: "Lightning Invoice",
              labelStyle: const TextStyle(color: AppTheme.grey2),
              hintText: "Enter invoice here",
              hintStyle: const TextStyle(color: AppTheme.grey2),
              filled: true,
              fillColor: AppTheme.dark1,
              alignLabelWithHint: true,
            ),
            maxLines: 4,
          ),
        ),
        const SizedBox(height: 16),
        // Action buttons.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              ElevatedButton(
                key: const Key('cancelInvoiceButton'),
                onPressed: widget.onCancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('CANCEL'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                key: const Key('submitInvoiceButton'),
                onPressed: widget.onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.mostroGreen,
                ),
                child: const Text('SUBMIT'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Future<void> dispose() async {
    await scannerController.dispose();
    super.dispose();
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = const Color.fromRGBO(0, 0, 0, 0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOver;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
