import 'package:flutter/material.dart';
import 'package:kelulusan/model/user.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserModel.of(context).user;

    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor
                  ),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
                                  tag: user.nis,
                                  child: Icon(
                                    Icons.supervised_user_circle,
                                    size: 60,
                                  ),
                                ),
                                radius: 30,
                              ),
                              SizedBox(height: 20),
                              Text(
                                user.nama,
                                style: Theme.of(context).textTheme.title,
                              ),
                              Text(
                                user.kompetensi,
                                style: Theme.of(context).textTheme.subtitle.apply(
                                  color: Colors.black54
                                ),
                              ),
                              SizedBox(height: 50,),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Anda Dinyatakan : ',
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  _LulusComponent(user: user)
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () async {
                            if (await canLaunch(user.pdf)) {
                              await launch(user.pdf);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.file_download),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: Text('Anda Bisa Mendownload File Disini'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed("/");
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.lock_open),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: Text('Logout'),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

class _LulusComponent extends StatefulWidget {
  _LulusComponent({Key key, this.user}) : super(key: key);

  final User user;

  @override
  State<StatefulWidget> createState() => _LulusComponentState();
}

class _LulusComponentState extends State<_LulusComponent> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _textAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));

    _textAnimation = TextTween(widget.user.keterangan).animate(_animationController);

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
      style: Theme.of(context).textTheme.body1.apply(
        fontWeightDelta: 10
      ),
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