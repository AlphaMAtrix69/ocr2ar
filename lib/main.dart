import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:test_ocr/Screen/recognization_page.dart';
import 'package:test_ocr/Widgets/modal_dialog.dart';
import 'package:camera/camera.dart';
import 'package:photo_manager/photo_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'OCR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CameraDescription>? cameras;
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras!.isNotEmpty) {
        // Start the camera
        onNewCameraSelected(cameras![0]);
      }
    });
  }

  Future<void> onNewCameraSelected(CameraDescription camera) async {
    cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    await cameraController.initialize();

    setState(() {
      // Update camera state
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> pickImageFromGallery() async {
    final List<AssetPathEntity> assets = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: true,
    );

    var assetList;
    // final List<AssetEntity> imageList = await assets[0].assetList;
    // Display the list of images and allow selection
  }

  void selectImageFromGallery() {
    pickImageFromGallery().then((value) {
      // Handle selected image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          imagePickerModal(context, onCameraTap: () {
            log("Camera");
            pickImageFromCamera().then((value) {});
          }, onGalleryTap: () {
            log("Gallery");
            selectImageFromGallery();
          });
        },
        tooltip: 'Increment',
        label: const Text("Scan Photo"),
      ),
    );
  }

  pickImageFromCamera() {}
}
