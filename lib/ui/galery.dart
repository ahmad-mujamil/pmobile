import 'package:flutter/material.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';


class Galery extends StatefulWidget {
  const Galery({super.key});
  @override
  State<Galery> createState() => _GaleryState();
}

class _GaleryState extends State<Galery> {

  final List<ImageProvider> _imageProviders = [
    Image.network("https://picsum.photos/id/237/200/300").image,
    Image.network("https://picsum.photos/seed/picsum/200/300").image,
    Image.network("https://picsum.photos/200/300?grayscale").image,
    Image.network("https://picsum.photos/200/300").image,
    Image.network("https://picsum.photos/200/300?grayscale").image
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Galery Foto',style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: false,
        
        ),
        body: GalleryImageView(
          listImage: _imageProviders,
          width: double.infinity,
          height: 500,
          imageDecoration: BoxDecoration(border: Border.all(color: Colors.white)),
        ),
      );
  }
}
