import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'QR Code scanner POC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScanResult qrCodeResult;

  Future<void> scanQrCode() async {
    qrCodeResult = await BarcodeScanner.scan(
      options: ScanOptions(
        restrictFormat: [BarcodeFormat.qr],
      )
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            qrCodeResult == null
                ? Text(
                    'Please Scan the QR Code',
                    style: Theme.of(context).textTheme.headline4,
                  )
                : buildQRWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Scan QR Code',
        onPressed: () {
          scanQrCode();
        },
        child: Icon(Icons.camera_alt),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildQRWidget() {
    if(qrCodeResult==null) return CircularProgressIndicator() ;
    return Column(
      children: [
        buildQrInfoTile( 'Result Type' , qrCodeResult.type) ,
        buildQrInfoTile( 'Data from Code', qrCodeResult.rawContent) ,
        buildQrInfoTile( 'BarCode Format', qrCodeResult.format.toString().toUpperCase()) ,
        buildQrInfoTile('Format extra Info', qrCodeResult.formatNote) ,
      ],
    );
  }

  Widget buildQrInfoTile(Object key , Object value) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Wrap(
            children: [
              Text(key.toString() , style: TextStyle(fontWeight: FontWeight.bold),) ,
              Text('  :  ') ,
              Text(value.toString())
            ],
          ),
        ),
      ),
    );
  }
}
