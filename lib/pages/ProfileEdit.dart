import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../global.dart' as global;
class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

var username = TextEditingController();
var first_name = TextEditingController();
var email = TextEditingController();
var last_name = TextEditingController();
var phone = TextEditingController();
var store_name = TextEditingController();
var newpass = TextEditingController();
var duppass = TextEditingController();
var showPass = false;
var currPass = TextEditingController();
class _ProfileEditState extends State<ProfileEdit> {
  File? _imageFile;
  String? base64Image = "";
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    username.text = global.username;
    first_name.text = global.first_name;
    last_name.text = global.last_name;
    first_name.text = global.first_name;
    email.text = global.email;
    phone.text = global.phone_number;
    store_name.text = global.storeName;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.085,
          child: ElevatedButton(
            onPressed: () {
              if (newpass.text == duppass.text) {
                  global.putRequest({
                    "first_name" : first_name.text,
                    "last_name" : last_name.text,
                    "email" : email.text,
                    "current_password" : currPass.text,
                    "password" : newpass.text
                  }, '/customer_edit_profile/');
              }
              Navigator.pop(context);
// committing
              global.toast(context, "پروفایل با موفقیت ویرایش شد", null);
            },
            child: const Text(
              "  ثبت تغییرات   ",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFF256F46))),
          ),
        ),
      ),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF256F46),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 75, // Adjust the radius as needed
                      backgroundColor: Colors.transparent, // Make the background transparent
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75), // Same radius as the CircleAvatar
                        child: Container(
                          width: 150, // Width of the IconButton
                          height: 150, // Height of the IconButton
                          child: IconButton(
                            padding: EdgeInsets.zero, // Remove padding around the icon
                            icon: _imageFile != null
                                ? Image.file(
                              _imageFile!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover, // Ensure the image fills the IconButton
                            )
                                : global.profile_imge == ""? const ImageIcon(
                              AssetImage("images/addimage.png"),
                              color: Color(0xFF1c5334),
                              size: 150, // Size of the ImageIcon
                            ) : ClipRRect(
                              borderRadius: BorderRadius.circular(75), // Same radius as the CircleAvatar
                              child: Image.memory(
                                width: 150,
                                Uint8List.fromList(
                                    base64Decode(global.profile_imge)),
                                fit: BoxFit
                                    .cover, // Adjust the fit as needed
                              ),
                            ),
                            onPressed: () async {
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);

                                if (image != null) {
                                  (await cropImageToSquare(
                                      File(image.path))) as File?;
                                  // If you need the base64 string for any purpose
                                  List<int> imageBytes = await _imageFile!
                                      .readAsBytes();
                                  base64Image = base64Encode(imageBytes);
                                } else {
                                  print('No image selected.');
                                }
                            },
                            iconSize: 150, // Size of the IconButton
                          ),
                        ),
                      ),
                    ),
                    _imageFile != null || global.profile_imge != ""? IconButton(
                      icon: const Icon(
                        Icons.highlight_remove_rounded, // Use any icon you prefer for deleting the image
                        color: Colors.red, // Change the color if needed
                      ),
                      onPressed: () {
                        setState(() {
                          if (global.profile_imge != "")
                            global.profile_imge = "";
                           // Set _imageFile to null
                        else _imageFile = null;
                        });
                      },
                      iconSize: 30, // Adjust the size of the icon as needed
                    ) : Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        readOnly: true,
                        controller: username,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  نام کاربری  ',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        controller: first_name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  نام  ',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        controller: last_name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  نام خانوادگی  ',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
              global.userKind == "Seller"? Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        controller: store_name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  نام فروشگاه  ',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ) : Container(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  ایمیل  ',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        readOnly: true,
                        controller: phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  شماره تلفن  ',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        controller: currPass,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  رمز فعلی  ',
                          floatingLabelStyle: TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        obscureText: !showPass,
                        controller: newpass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              showPass = !showPass;
                            });
                          }, icon: const Icon(Icons.remove_red_eye)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: '  رمز جدید  ',
                          floatingLabelStyle: const TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: const TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 20),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.redAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        obscureText: !showPass,
                        controller: duppass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              showPass = !showPass;
                            });
                          }, icon: const Icon(Icons.remove_red_eye)),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          labelText: ' تکرار رمز جدید  ',
                          floatingLabelStyle: const TextStyle(fontSize: 25),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: const TextStyle(fontSize: 25, fontFamily: 'shabnam'),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<File> cropImageToSquare(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final img.Image? image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception("Could not decode image.");
    }

    int shortestSide = image.width < image.height ? image.width : image.height;
    int xOffset = (image.width - shortestSide) ~/ 2;
    int yOffset = (image.height - shortestSide) ~/ 2;

    final img.Image croppedImage = img.copyCrop(
      image,
      x: xOffset,
      y: yOffset,
      width: shortestSide,
      height: shortestSide,
    );

    final croppedFile = await imageFile.writeAsBytes(img.encodePng(croppedImage));
    setState(() {
      _imageFile = croppedFile;
    });
    return croppedFile;
  }

}
