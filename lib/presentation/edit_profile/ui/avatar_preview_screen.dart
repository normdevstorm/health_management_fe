import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_cropper/image_cropper.dart';

class AvatarHoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: 150.r,
      ))
      ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AvatarPreviewScreen extends StatefulWidget {
  final File imageFile;
  const AvatarPreviewScreen({required this.imageFile, Key? key})
      : super(key: key);

  @override
  State<AvatarPreviewScreen> createState() => _AvatarPreviewScreenState();
}

class _AvatarPreviewScreenState extends State<AvatarPreviewScreen> {
  bool _isLoading = false;
  late File _currentImage;

  @override
  void initState() {
    super.initState();
    _currentImage = widget.imageFile;
  }

  Future<void> _cropImage() async {
    setState(() => _isLoading = true);
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _currentImage.path,
        // : [
        //   CropAspectRatioPreset.square,
        // ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Avatar',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _currentImage = File(croppedFile.path);
        });
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.crop),
            onPressed: _cropImage,
          ),
        ],
      ),
      body: Stack(
        children: [
          PhotoView(
            imageProvider: FileImage(_currentImage),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          ClipPath(
            clipper: AvatarHoleClipper(),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Guide text
          const InstructionWidget(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => context.pop(context),
                icon: const Icon(Icons.close),
                label: const Text('Cancel'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  context.pop(_currentImage);
                },
                icon: const Icon(Icons.check),
                label: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50.h,
      left: 0,
      right: 0,
      child: Text(
        'Move and Scale\nThe avatar should look this way',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
