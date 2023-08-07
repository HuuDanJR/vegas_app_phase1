import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/base/mixin/function_mixin.dart';
import 'package:vegas_club/ui/share_widget/input_field.widget.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/ui/view/login-screen/login.screen.dart';
import 'package:vegas_club/view_model/login_screen.viewmodel.dart';
import 'package:vegas_club/view_model/profile_screen.viewmodel.dart';

class ChangePasswordScreen extends StateFullConsumer {
  const ChangePasswordScreen({super.key});
  static const String routeName = "./change_password";
  @override
  StateConsumer<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends StateConsumer<ChangePasswordScreen>
    with BaseFunction {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isHideNewsPassword = true;
  bool isHideConfirmNewPassword = true;
  TextEditingController? _passwordController;
  TextEditingController? _confirmPasswordController;
  @override
  void initStateWidget() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }
  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: appBarBottomBar(_scaffoldKey,
            context: context,
            title: "Change password",
            actions: [], onClose: () {
          pop();
        }),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              CustomFormField(
                hintText: "Enter your password",
                labelText: "Enter your new password",
                obscureText: isHideNewsPassword ? true : false,
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isHideNewsPassword = !isHideNewsPassword;
                      });
                    },
                    child: !isHideNewsPassword
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          )),
                textEditingController: _passwordController,
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomFormField(
                hintText: "Enter confirm new password",
                labelText: "Confirm new password",
                obscureText: isHideConfirmNewPassword ? true : false,
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isHideConfirmNewPassword = !isHideConfirmNewPassword;
                      });
                    },
                    child: !isHideConfirmNewPassword
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.black,
                          )),
                textEditingController: _confirmPasswordController,
              ),
              const SizedBox(
                height: 10.0,
              ),
              buttonView(
                  height: 30,
                  width: width(context),
                  onPressed: () {
                    if (_passwordController!.text !=
                        _confirmPasswordController!.text) {
                      showAlertDialog(
                          typeDialog: TypeDialog.warning,
                          title:
                              "Your confirm password is not the same with your password!");
                    } else {
                      Provider.of<ProfileViewModel>(context, listen: false)
                          .changePassword(
                              newsPassword: _passwordController!.text,
                              confirmPassword: _confirmPasswordController!.text,
                              onSucess: () {
                                showAlertDialog(
                                  typeDialog: TypeDialog.success,
                                  title: "Change password success!",
                                  onSuccess: () {
                                    pop();
                                    Provider.of<LoginScreenViewModel>(context,
                                            listen: false)
                                        .logout(onSucess: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const LoginScreen()),
                                          ModalRoute.withName('/'));
                                    });
                                  },
                                );
                              });
                    }
                  },
                  text: "Change password"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
