import 'package:flutter/material.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/model/request/user_login_request.dart';
import 'package:music_player/model/response/token.dart';
import 'package:music_player/ui/register_page.dart';
import 'package:music_player/ui/songs_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  late bool hidePass;

  @override
  void initState() {
    email = null;
    password = null;

    hidePass = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Form(
        key: _formKey,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Center(
              child: Text(
                "NEO MUSIC 🎸",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                label: Text("Email"),
                prefixIcon: Icon(Icons.alternate_email_outlined),
                prefixIconColor: Colors.pinkAccent,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập email';
                }

                RegExp regExp = RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                );
                if (!regExp.hasMatch(value)) {
                  return 'Định dạng email không đúng';
                }

                return null;
              },
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: hidePass,
              decoration: InputDecoration(
                label: Text("Password"),
                prefixIcon: Icon(Icons.lock_outline),
                prefixIconColor: Colors.pinkAccent,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: hidePass
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                        icon: Icon(Icons.visibility),
                      )
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                        icon: Icon(Icons.visibility_off),
                      ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                return null;
              },
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );

                  UserLoginRequest request = UserLoginRequest(
                    email: email!,
                    password: password!,
                  );

                  Api api = Api();
                  Token? token = await api.login(request);
                  if (token == null) {
                    // Dang nhap that bai
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đăng nhập thất bại')),
                    );
                    return;
                  }

                  // Dang nhap thanh cong
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Đăng nhập thành công')),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SongsPage(accessToken: token.accessToken),
                    ),
                  );
                }
              },
              child: const Text('Đăng nhập'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
              ),
            ),
            Center(child: Text('Chưa có tài khoản?')),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Đăng ký",
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
