import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kelulusan/model/galery.dart';
import 'package:kelulusan/model/photo.dart';
import 'package:kelulusan/network.dart';
import 'package:kelulusan/provider/user_model.dart';
import 'package:provider/provider.dart';

class GaleryPage extends StatefulWidget {
  final Galery galery;

  const GaleryPage({super.key, required this.galery});

  @override
  State<GaleryPage> createState() => _GaleryPageState();
}

class _GaleryPageState extends State<GaleryPage> {
  @override
  Widget build(BuildContext context) {
    var userLogin = Provider.of<UserModel>(context, listen: false).user;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: BackButton(),
          centerTitle: true,
          title: Text(widget.galery.name ?? ''),
          actions: [
            IconButton(
              icon: FaIcon(
                  (widget.galery.likeByYou ?? false)
                      ? FontAwesomeIcons.solidHeart
                      : FontAwesomeIcons.heart,
                  color: Colors.red),
              onPressed: () {
                Future<bool> future;
                if (widget.galery.likeByYou ?? false) {
                  future = Network.instance.likeGalery(
                      widget.galery.id!.toInt(), userLogin.token);
                } else {
                  future = Network.instance.unlikeGalery(
                      widget.galery.id!.toInt(), userLogin.token);
                }
                future.then((value) {
                  setState(() {
                    widget.galery.likeByYou = !(widget.galery.likeByYou ?? false);
                    if (widget.galery.likeByYou!) {
                      widget.galery.likesCount =
                          widget.galery.likesCount!.toInt() + 1;
                    } else {
                      widget.galery.likesCount =
                          widget.galery.likesCount!.toInt() - 1;
                    }
                  });
                });
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.galery.photos?.length ?? 0,
              itemBuilder: (context, index) {
                var photo = widget.galery.photos![index];

                return Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: photo.image ?? '',
                      height: 250,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: FaIcon(
                              (photo.likeByYou ?? false)
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              color: Colors.red),
                          onPressed: () {
                            Future<bool> future;
                            if (photo.likeByYou ?? false) {
                              future = Network.instance.likePhoto(
                                  photo.id!.toInt(), userLogin.token);
                            } else {
                              future = Network.instance.unlikePhoto(
                                  photo.id!.toInt(), userLogin.token);
                            }
                            future.then((value) {
                              setState(() {
                                photo.likeByYou = !(photo.likeByYou ?? false);
                                if (photo.likeByYou!) {
                                  photo.likesCount =
                                      photo.likesCount!.toInt() + 1;
                                } else {
                                  photo.likesCount =
                                      photo.likesCount!.toInt() - 1;
                                }
                              });
                            });
                          },
                        ),
                        Text(photo.likesCount.toString()),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
