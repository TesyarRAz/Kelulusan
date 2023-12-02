import 'package:flutter/material.dart';
import 'package:kelulusan/model/galery.dart';
import 'package:kelulusan/model/user.dart';
import 'package:kelulusan/network.dart';
import 'package:kelulusan/provider/user_model.dart';
import 'package:kelulusan/screen/galery_page.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, userModel, _) {
        return Scaffold(
          body: SafeArea(
            child: ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Card(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    child: Hero(
                                      tag: userModel
                                              .user?.user?.student?.noInduk ??
                                          '',
                                      child: Icon(
                                        Icons.supervised_user_circle,
                                        size: 60,
                                      ),
                                    ),
                                    radius: 30,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    userModel.user?.user?.name ?? '-',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    (userModel.user?.user?.student?.kelas
                                                ?.name ??
                                            '') +
                                        ' ' +
                                        (userModel.user?.user?.student?.angkatan
                                                ?.tahun
                                                .toString() ??
                                            ''),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.apply(color: Colors.black54),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  // Row(
                                  //   children: <Widget>[
                                  //     Text(
                                  //       'Anda Dinyatakan : ',
                                  //       style: Theme.of(context).textTheme.bodyLarge,
                                  //     ),
                                  //     // _LulusComponent(user: user)
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          ),
                          // Card(
                          //   child: InkWell(
                          //     onTap: () async {
                          //       if (await canLaunchUrl(Uri.parse(userModel.user?.user?.pdf))) {
                          //         await launchUrl(Uri.parse(userModel.user?.user?.pdf));
                          //       }
                          //     },
                          //     child: Container(
                          //       padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          //       width: MediaQuery.of(context).size.width,
                          //       child: Row(
                          //         children: <Widget>[
                          //           Icon(Icons.file_download),
                          //           SizedBox(width: 20,),
                          //           Expanded(
                          //             child: Text('Surat Kelulusan'),
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed("/");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.lock_open),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text('Logout'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // Center(
                          //   child: Column(
                          //     children: <Widget>[
                          //       Image.asset(
                          //         "assets/smea.png",
                          //         height: 150,
                          //         width: 150,
                          //       ),
                          //       SizedBox(height: 20,),
                          //       Text(
                          //         'Copyright @ SMKN 2 Kota Sukabumi',
                          //         style: Theme.of(context).textTheme.bodyLarge
                          //       )
                          //     ],
                          //   )
                          // ),
                          Text(
                            "Galery",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FutureBuilder<List<Galery>>(
                            future: Network.instance
                                .getGaleries(userModel.user!.token),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Card(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return _buildGaleryItem(
                                          snapshot.data![index]);
                                    },
                                  ),
                                );
                              }

                              return Container();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGaleryItem(Galery galery) => ListTile(
        title: Text((galery.angkatan?.tahun?.toString() ?? '') + ' - ' + (galery.kelas?.name ?? '') + ' ' + (galery.name ?? '')),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => GaleryPage(galery: galery))
          );
        },
      );
}

class _LulusComponent extends StatefulWidget {
  _LulusComponent({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<StatefulWidget> createState() => _LulusComponentState();
}

class _LulusComponentState extends State<_LulusComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _textAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));

    _textAnimation = TextTween("").animate(_animationController);

    _animationController.addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _textAnimation.value,
      style: Theme.of(context).textTheme.bodyLarge?.apply(fontWeightDelta: 10),
    );
  }
}

class TextTween extends Tween<String> {
  final String text;

  TextTween(this.text) : super(begin: "", end: text);

  @override
  String lerp(double t) {
    int last = (t * 10).round();
    return text.substring(0, last < text.length ? last : text.length);
  }
}
