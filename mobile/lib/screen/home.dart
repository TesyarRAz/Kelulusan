import 'package:flutter/material.dart';
import 'package:kelulusan/model/user.dart';
import 'package:kelulusan/widget/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var user = UserModel.of(context).user!;

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
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
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
                                tag: user.student?.noInduk ?? '',
                                child: Icon(
                                  Icons.supervised_user_circle,
                                  size: 60,
                                ),
                              ),
                              radius: 30,
                            ),
                            SizedBox(height: 20),
                            Text(
                              user.name ?? '-',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              (user.student?.kelas?.name ?? '') + ' ' + (user.student?.angkatan?.tahun.toString() ?? ''),
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
                    //       if (await canLaunchUrl(Uri.parse(user.pdf))) {
                    //         await launchUrl(Uri.parse(user.pdf));
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
                      height: 100,
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
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
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
