import 'package:flutter/material.dart';
import 'package:kelulusan/helper.dart';
import 'package:kelulusan/model/user.dart';
import 'package:kelulusan/network.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController _nis;
  TextEditingController _password;

  bool _passwordShow;

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
            Icon(
              Icons.supervised_user_circle,
              size: 100,
            ),
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
      style: Theme.of(context).primaryTextTheme.body2,
    ),
    onPressed: () {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Helper.createLoading(),
        )
      );
      Network.instance.loginAndGetUserdata(_nis.text, _password.text)
      .then((result) {
        Navigator.of(context).pop();
        if (result is User) {
          setState(() {
            UserModel.of(context).user = result;
            Navigator.of(context).pushReplacementNamed("/home");
          });
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