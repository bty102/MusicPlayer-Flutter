import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/model/request/user_register_request.dart';
import 'package:music_player/model/response/token.dart';
import 'package:music_player/ui/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? name;
  bool? isMale;
  int? age;
  String? phoneNumber;
  String? address;
  String? bio;

  late bool hidePass;

  @override
  void initState() {
    email = null;
    password = null;
    name = null;
    isMale = true;
    age = null;
    phoneNumber = null;
    address = null;
    bio = null;

    hidePass = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký', style: TextStyle(fontWeight: FontWeight.bold)),
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
                "NEO MUSIC 🎶",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: Icon(Icons.alternate_email),
                prefixIconColor: Colors.pinkAccent,
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
                label: Text('Password'),
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
                if (value.length < 4) {
                  return 'Mật khẩu phải có ít nhât 4 ký tự';
                }
                return null;
              },
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Name'),
                prefixIcon: Icon(Icons.person_outline_sharp),
                prefixIconColor: Colors.pinkAccent,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên';
                }
                if (value.length < 3) {
                  return 'Tên phải có ít nhất 3 ký tự';
                }
                return null;
              },
              onChanged: (value) {
                name = value;
              },
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text('Giới tính nam?'),
              activeColor: Colors.pinkAccent,
              checkColor: Colors.white,
              // tileColor: const Color.fromARGB(255, 223, 213, 213),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              value: isMale,
              onChanged: (value) {
                setState(() {
                  isMale = value;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                label: Text('Tuổi'),

                prefixIcon: Icon(Icons.cake_outlined),
                prefixIconColor: Colors.pinkAccent,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tuổi';
                }
                int? age = int.tryParse(value);
                if (age == null) {
                  return 'Tuổi không hợp lệ';
                }
                if (age < 16) {
                  return 'Tuổi thấp nhất là 16';
                }
                return null;
              },
              onChanged: (value) {
                age = int.tryParse(value);
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                label: Text('Số điện thoại'),
                prefixIcon: Icon(Icons.phone_android),
                prefixIconColor: Colors.pinkAccent,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập số điện thoại';
                }
                RegExp phoneRegex = RegExp(r'^0\d{9}$');
                if (!phoneRegex.hasMatch(value)) {
                  return 'Số điện thoại không hợp lệ';
                }
                return null;
              },
              onChanged: (value) {
                phoneNumber = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Địa chỉ'),
                prefixIcon: Icon(Icons.location_on_outlined),
                prefixIconColor: Colors.pinkAccent,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập địa chỉ';
                }
                return null;
              },
              onChanged: (value) {
                address = value;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              minLines: 1,
              maxLines: null,
              decoration: InputDecoration(
                label: Text('Tiểu sử'),
                prefixIcon: Icon(Icons.menu_book),
                prefixIconColor: Colors.pinkAccent,
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (value) {
                bio = value;
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

                  Api api = Api();
                  UserRegisterRequest request = UserRegisterRequest(
                    email: email!,
                    password: password!,
                    name: name!,
                    isMale: isMale!,
                    age: age!,
                    phoneNumber: phoneNumber!,
                    address: address!,
                    bio: bio,
                  );
                  Token? token = await api.register(request);
                  if (token == null) {
                    // Dang ky that bai
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đăng ký thất bại')),
                    );
                    return;
                  }
                  // Dang ky thanh cong
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Đăng ký thành công')),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                }
              },
              child: const Text('Đăng ký'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
