
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../resourses/colors.dart';
import '../Paths/imports.dart';

class ScanerScreen extends StatefulWidget {
  const ScanerScreen({super.key});

  @override
  State<ScanerScreen> createState() => _ScanerScreenState();
}

List<String> BarCodeResults = ['DeepMind'];

class _ScanerScreenState extends State<ScanerScreen> {
  bool isflashOn = false;
  bool isfrountCam = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: MyColors.bgBlue,
        foregroundColor: MyColors.bgBlue,
        elevation: 0,
        backgroundColor: MyColors.bgBlue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 75,
        title: Text(
          'Scan Code',
          style: TextStyle(
              fontFamily: "Lora",
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: MyColors.white),
        ),
      ),
      body: Center(
        child: MobileScanner(
          controller: MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates,
            returnImage: true,
          ),
          onDetect: (capture){
            print(capture);
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            for(final barcode in barcodes){
              Results(barcode);
              BarCodeResults.add(barcode.rawValue.toString());
              NavigateToReplace(context,NavigationbarScreen() );

              print('BarCode is ${barcode.rawValue}');

            }
          },
        )
      )

    );
  }
  Results(barcode){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Result is ${barcode.rawValue}', style: TextStyle(
      color: MyColors.white
    ),), duration: Duration(seconds: 10),backgroundColor: MyColors.darkpink,
      action: SnackBarAction(label: 'Ok', onPressed: (){})
    ));
  }
}
