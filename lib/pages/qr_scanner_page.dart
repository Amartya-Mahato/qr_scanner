import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/result_page.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  Uint8List bytes = Uint8List(0);
  String str = 'anonymos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Generator'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              onChanged: (value) {
                str = value;
              },
              decoration: const InputDecoration(
                  hintText: 'Paste your link',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple))),
            ),
          ),
          Container(
            child: bytes.isEmpty
                ? const Text(
                    'Link Not Provided',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                : Image.memory(
                    bytes,
                    height: 200,
                    width: 200,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  _generateBarCode(str);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade800),
                child: const Text('Generate'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _scan();
        },
        backgroundColor: Colors.red.shade800,
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();

    if (barcode != null) {
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => ResultPage(result: barcode)));
    }
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    setState(() => bytes = result);
  }
}
