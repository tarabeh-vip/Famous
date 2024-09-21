import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // تأكد من إضافة Dio في pubspec.yaml

class ImageViewScreen extends StatefulWidget {
  final String imageUrl;

  ImageViewScreen({required this.imageUrl});

  @override
  _ImageViewScreenState createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  final Dio _dio = Dio();

  Future<void> downloadImage() async {
    try {
      final response = await _dio.get(
        widget.imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/downloaded_image.jpg';

      final file = File(filePath);
      await file.writeAsBytes(response.data);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image downloaded to $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        title: Text('Image View'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(
              Icons.download,
              color: Colors.indigoAccent.shade200,
              shadows: [
                Shadow(color: Colors.white),
              ],
            ),
            onPressed: downloadImage,
          ),


        ],
      ),

      body:
      Center(
        child: Image.network(widget.imageUrl),

      ),
    );
  }

  getApplicationDocumentsDirectory() {}
}
