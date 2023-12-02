import 'package:flutter/material.dart';
import 'package:kelulusan/model/galery.dart';
import 'package:kelulusan/model/photo.dart';
import 'package:kelulusan/network.dart';

class GaleryPage extends StatefulWidget {
  final Galery galery;

  const GaleryPage({super.key, required this.galery});

  @override
  State<GaleryPage> createState() => _GaleryPageState();
}

class _GaleryPageState extends State<GaleryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: FutureBuilder<List<Photo>>(
          future: Network.instance.getGaleries(token),
        ),
      ),
    );
  }
}
