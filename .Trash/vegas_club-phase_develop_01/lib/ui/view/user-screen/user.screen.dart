import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:provider/provider.dart';

import 'package:vegas_club/api/repository/repository.dart';
import 'package:vegas_club/base/base_state_widget.dart';
import 'package:vegas_club/base/base_widget.dart';
import 'package:vegas_club/common/utils/utils.dart';
import 'package:vegas_club/file_asset_gen/colors.gen.dart';
import 'package:vegas_club/file_asset_gen/fonts.gen.dart';
import 'package:vegas_club/global_constant.dart';
import 'package:vegas_club/models/response/customer_response.dart';
import 'package:vegas_club/service/authentication.service.dart';
import 'package:vegas_club/ui/share_widget/input_field.widget.dart';
import 'package:vegas_club/ui/share_widget/share.widget.dart';
import 'package:vegas_club/ui/view/login-screen/login.screen.dart';
import 'package:vegas_club/ui/view/user-screen/chage_password.screen.dart';
import 'package:vegas_club/view_model/login_screen.viewmodel.dart';
import 'package:vegas_club/view_model/user.viewmodel.dart';
import '../../../config/hive_config.dart';
// import 'package:file_p';
import 'package:path_provider/path_provider.dart' as path_provider;

class UserScreen extends StateFullConsumer {
  const UserScreen({Key? key}) : super(key: key);
  static const String routeName = "./userName";
  @override
  StateConsumer<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends StateConsumer<UserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CustomerResponse? _customerResponse;
  TextEditingController? _usernameController;
  TextEditingController? _memberShipLeverController;
  TextEditingController? _genderController;
  TextEditingController? _nationalityController;
  TextEditingController? _currentPasswordController;
  bool _showFunctionDelete = false;
  final _repository = Repository();

  @override
  void initStateWidget() {
    _usernameController = TextEditingController();
    _memberShipLeverController = TextEditingController();
    _genderController = TextEditingController();
    _nationalityController = TextEditingController();
    _currentPasswordController = TextEditingController();
    getCustomer();
  }

  Future<void> getCustomer() async {
    _customerResponse = await boxAuth!.get(userCustomer);
    String? showFunctionDelete = await boxSetting!.get(settingFunctionDelete);
    _showFunctionDelete =
        (showFunctionDelete != null && showFunctionDelete == "1")
            ? true
            : false;
    if (_customerResponse != null) {
      _usernameController!.text = _customerResponse!.getUserName();
      _memberShipLeverController!.text = _customerResponse!.membershipTypeName!;
      _genderController!.text = _customerResponse!.gender!;
      _nationalityController!.text = _customerResponse!.getNationality();
      setState(() {});
    }
  }

  File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file;
  }

  Future<File?> _testCompressFile(File fileTmp) async {
    final img = AssetImage(fileTmp.absolute.path);
    print('pre compress');
    const config = ImageConfiguration();
    final AssetBundleImageKey key = await img.obtainKey(config);
    final ByteData data = await key.bundle.load(key.name);
    final dir = await path_provider.getTemporaryDirectory();
    final File file = createFile('${dir.absolute.path}/test.png');
    file.writeAsBytesSync(data.buffer.asUint8List());
    final targetPath = '${dir.absolute.path}/temp.jpg';

    final result = await testCompressAndGetFile(file, targetPath);

    if (result == null) return null;
    return result;
  }

  Future<File?> testCompressAndGetFile(File file, String targetPath) async {
    print('testCompressAndGetFile');
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 90,
      minWidth: 1024,
      minHeight: 1024,
      rotate: 0,
    );
    print(file.lengthSync());
    print(result?.lengthSync());
    return result;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBarBottomBar(_scaffoldKey,
            context: context, title: "User Profile", actions: [], onClose: () {
          pop();
        }),
        body: _customerResponse != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Personal Detail",
                          style: TextStyle(
                              fontSize: isSmallScreen(context) ? 16 : 20.0,
                              color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.image,
                            );

                            if (result != null) {
                              List<File> files = result.paths
                                  .map((path) => File(path!))
                                  .toList();
                              var compress =
                                  await _testCompressFile(files.first);

                              if (compress != null) {
                                Provider.of<UserViewmodel>(context,
                                        listen: false)
                                    .uploadAvatar(File(compress.path),
                                        onSuccess: (customer) async {
                                  await boxAuth!.put(userCustomer, customer);
                                  Provider.of<LoginScreenViewModel>(context,
                                          listen: false)
                                      .getProfile();
                                });
                              }
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: FittedBox(
                            child: Container(
                              color: Colors.transparent,
                              child: const Text(
                                "Change avatar",
                                style: TextStyle(
                                    fontSize: 18.0, color: ColorName.primary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Consumer<LoginScreenViewModel>(
                        builder: (context, model, _) {
                      print(Utils.getImageFromId(
                          model.customerResponse!.attachmentId ?? -1));
                      return Center(
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.0)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: Utils.getImageFromId(
                                  model.customerResponse!.attachmentId ?? -1),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                color: Colors.grey.shade300,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomFormField(
                      readOnly: true,
                      labelText: "Name",
                      textEditingController: _usernameController,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomFormField(
                      readOnly: true,
                      labelText: "Member level",
                      textEditingController: _memberShipLeverController,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomFormField(
                      readOnly: true,
                      labelText: "Gender",
                      textEditingController: _genderController,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    CustomFormField(
                      readOnly: true,
                      labelText: "Nationality",
                      textEditingController: _nationalityController,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    buttonView(
                        height: 30.0,
                        width: width(context),
                        onPressed: () {
                          pushNamed(ChangePasswordScreen.routeName);
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return AlertDialog(
                          //         title: Center(
                          //           child: Text(
                          //             'Confirm current password',
                          //             style: TextStyle(color: Colors.black),
                          //           ),
                          //         ),
                          //         content: Column(
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: [
                          //             CustomFormField(
                          //               hintText: "Enter your current password",
                          //               obscureText: true,
                          //               textEditingController:
                          //                   _currentPasswordController,
                          //             ),
                          //             SizedBox(
                          //               height: 10.0,
                          //             ),
                          //             buttonView(
                          //                 width: width(context),
                          //                 onPressed: () {},
                          //                 text: "Confirm")
                          //           ],
                          //         ),
                          //       );
                          //     });
                        },
                        text: "Change Password"),
                    const Expanded(child: SizedBox()),
                    _showFunctionDelete
                        ? ElevatedButton(
                            onPressed: () async {
                              Provider.of<LoginScreenViewModel>(context,
                                      listen: false)
                                  .logout(onSucess: () async {
                                int id =
                                    await ProfileUser.getCurrentCustomerId();
                                _repository.removeAccount(id);

                                pushReplaceName(LoginScreen.route);
                              });
                            },
                            child: const Center(
                              child: Text(
                                'Delete Account',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FontFamily.quicksand),
                              ),
                            ))
                        : const SizedBox(),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                ))
            : const SizedBox());
  }

  @override
  void disposeWidget() {
    // TODO: implement disposeWidget
  }
}
