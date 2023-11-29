import 'package:flutter/material.dart';
import 'package:kelulusan/helper.dart';
import 'package:kelulusan/model/user.dart';
import 'package:kelulusan/network.dart';
import 'package:kelulusan/widget/user_model.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  late TextEditingController _nis;
  late TextEditingController _password;

  late bool _passwordShow;

  @override
  void initState() {
    super.initState();
    
    _nis = TextEditingController();
    _password = TextEditingController();
    _passwordShow = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: "smea-icon",
              child: Image.asset(
                "assets/smea.png",
                width: 75,
                height: 75,
              ),
            ),
            // Icon(
            //   Icons.supervised_user_circle,
            //   size: 100,
            // ),
            SizedBox(height: 10,),
            _buildUsername(),
            SizedBox(height: 10,),
            _buildPassword(),
            SizedBox(height: 10,),
            _buildButton()
          ],
        ),
      ),
    );
  }

  Widget _buildUsername() => TextField(
    controller: _nis,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: "NIS"
    ),
  );

  Widget _buildPassword() => TextField(
    controller: _password,
    obscureText: !_passwordShow,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: "Password",
      suffixIcon: IconButton(
        icon: Icon(_passwordShow ? Icons.visibility : Icons.visibility_off),
        onPressed: () => setState(() {
          _passwordShow = !_passwordShow;
        }),
      )
    ),
  );

  Widget _buildButton() => MaterialButton(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    color: Theme.of(context).primaryColor,
    child: Text(
      'Login',
      style: Theme.of(context).primaryTextTheme.bodyMedium,
    ),
    onPressed: () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          child: Helper.createLoading(),
        )
      );
      Network.instance.loginAndGetUserdata(_nis.text, _password.text)
      .then((result) {
        Navigator.of(context).pop();
        if (result is User) {
          UserModel.of(context).user = result;
          Navigator.of(context).pushReplacementNamed("/home");
        } else {
          _nis.clear();
          _password.clear();
          
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Text(result),
            )
          );
        }
      });
    },
  );
}