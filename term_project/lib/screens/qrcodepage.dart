import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class QRCodePage extends StatefulWidget {
  final String username;
  const QRCodePage({super.key, required this.username});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 48, 85),
        title: Text(
          "Hoş Geldin ${widget.username}",
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: GestureDetector(
                  onTap: () async {
                    await getImage();
                  },
                  child: getMyImageAsset()),
            ),
          ],
        ),
      ),
    );
  }

  getMyImageAsset() {
    return Image.asset(
      "assets/qr1.png",
      height: 300.0,
    );
  }

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    // if (image != null) {
    //   final imageTemporary = File(image.path);
    //   setState(() {
    //     this.imageFile = imageTemporary;
    //   });
    // } else {
    //   QRCodePage();
    // }
  }
}
