import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtp_choice_web/models/UserFile.dart';
import 'package:mtp_choice_web/constants.dart' as constant;

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _MyAppState createState() =>
      _MyAppState(0, 0.01, 18, 0.08, 0.02, 0.08, 150, 0.02, 0.014, 0.02, 0.012);
}

class _MyAppState extends State<UpdateProfile> {
  late Future<Users> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchUser();
  }

  final GlobalKey<FormState> _formUpUs =
      new GlobalKey<FormState>(debugLabel: '_UpUsFormState');

  final paddingTopForm,
      fontSizeTextField,
      fontSizeTextFormField,
      spaceBetweenFields,
      iconFormSize;
  final spaceBetweenFieldAndButton,
      widthButton,
      fontSizeButton,
      fontSizeForgotPassword,
      fontSizeSnackBar,
      errorFormMessage;

  _MyAppState(
      this.paddingTopForm,
      this.fontSizeTextField,
      this.fontSizeTextFormField,
      this.spaceBetweenFields,
      this.iconFormSize,
      this.spaceBetweenFieldAndButton,
      this.widthButton,
      this.fontSizeButton,
      this.fontSizeForgotPassword,
      this.fontSizeSnackBar,
      this.errorFormMessage);
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.white,
      padding: EdgeInsets.fromLTRB(widthButton, 15, widthButton, 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      backgroundColor: Colors.blue,
    );
    return FutureBuilder<Users>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String fuln = '';
            final _usernameController =
                TextEditingController(text: snapshot.data!.userId);
            (snapshot.data!.fullname == null)
                ? fuln = ''
                : fuln = snapshot.data!.fullname!;
            final _fullnameController = TextEditingController(text: fuln);
            String ph = '';
            (snapshot.data!.phone == null)
                ? ph = ''
                : ph = snapshot.data!.phone!;
            // final _emailController = TextEditingController();
            final _phoneController = TextEditingController(text: ph);
            String pas = '';
            (snapshot.data!.password == null)
                ? pas = ''
                : pas = snapshot.data!.password!;

            final _passwordController = TextEditingController(text: pas);
            final _repasswordController = TextEditingController(text: pas);

            (snapshot.data!.image == null)
                ? constant.image = 'icons/Documents.svg'
                : constant.image = snapshot.data!.image!;
            print(snapshot.data);
            return Form(
                key: _formUpUs,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: widthSize * 0.05,
                        right: widthSize * 0.05,
                        top: heightSize * paddingTopForm),
                    child: Column(children: <Widget>[
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('User ID',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          enabled: false,
                          controller: _usernameController,
                          validator: (value) {
                            if (value == 'something') {
                              return 'Nhập tên người dùng của bạn để tiếp tục';
                            }
                          },
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.chat_outlined,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Họ và tên',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          controller: _fullnameController,
                          validator: (value) {
                            // String check = 'something';
                            // GetUtils.isEmail(value!)
                            //     ? check = 'something'
                            //     : check = 'fail';
                            // if (value == '') {
                            //   return 'Email không thể bỏ trống';
                            // }
                            // if (check == 'fail') {
                            //   return 'Email không hợp lệ';
                            // }
                          },
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.check_circle_outline,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Điện thoại',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          controller: _phoneController,
                          validator: (value) {
                            String check = 'something';
                            GetUtils.isPhoneNumber(value!)
                                ? check = 'something'
                                : check = 'fail';
                            if (check == 'fail') {
                              return 'Số điện thoại không hợp lệ';
                            }
                          },
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.clear_sharp,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Mật khẩu',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == 'something') {
                              return 'Mật khẩu không thể bỏ trống';
                            }
                          },
                          obscureText: true,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.clear_sharp,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFields),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('xác nhận mật khẩu',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeTextField,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      TextFormField(
                          controller: _repasswordController,
                          validator: (value) {
                            if (_repasswordController.text !=
                                _passwordController.text) {
                              return 'Mật khẩu phải giống xác nhận mật khẩu';
                            }
                            if (value == 'something') {
                              return 'xác nhận mật khẩu không thể để trống';
                            }
                          },
                          obscureText: true,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 2)),
                            labelStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(
                                color: Colors.white,
                                fontSize: widthSize * errorFormMessage),
                            prefixIcon: Icon(
                              Icons.clear_sharp,
                              size: widthSize * iconFormSize,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSizeTextFormField)),
                      SizedBox(height: heightSize * spaceBetweenFieldAndButton),
                      TextButton(
                          style: flatButtonStyle,
                          onPressed: () async {
                            if (_formUpUs.currentState!.validate()) {
                              patchUser(
                                      _usernameController.text,
                                      _phoneController.text,
                                      _passwordController.text,
                                      _fullnameController.text)
                                  .catchError((error) {
                                Get.snackbar('Alert', 'Nhập thất bại',
                                    duration: Duration(seconds: 4),
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.white);
                              });
                            }
                          },
                          child: Text('Cập nhật',
                              style: TextStyle(
                                  fontSize: widthSize * fontSizeButton,
                                  fontFamily: 'Poppins',
                                  color: Colors.white))),
                      SizedBox(height: heightSize * 0.01),
                    ])));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        });
  }
}
