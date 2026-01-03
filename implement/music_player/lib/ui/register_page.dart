import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/model/request/user_register_request.dart';
import 'package:music_player/model/response/token.dart';

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký 🎙️'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return Form(
      key: _formKey,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          TextFormField(
            decoration: InputDecoration(label: Text('Email')),
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
          TextFormField(
            decoration: InputDecoration(label: Text('Password')),
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
          TextFormField(
            decoration: InputDecoration(label: Text('Name')),
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
          CheckboxListTile(
            title: Text('Giới tính nam?'),
            value: isMale,
            onChanged: (value) {
              setState(() {
                isMale = value;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(label: Text('Tuổi')),
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
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(label: Text('Số điện thoại')),
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
          TextFormField(
            decoration: InputDecoration(label: Text('Địa chỉ')),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Vui lòng nhập địa chỉ';
              }
            },
            onChanged: (value) {
              address = value;
            },
          ),
          TextFormField(
            minLines: 3,
            maxLines: null,
            decoration: InputDecoration(label: Text('Tiểu sử')),
            onChanged: (value) {
              bio = value;
            },
          ),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đăng ký thành công')),
                );
              }
            },
            child: const Text('Đăng ký'),
          ),
        ],
      ),
    );
  }
}
