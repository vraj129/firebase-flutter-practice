import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pineapp/widget/app_button.dart';
import 'package:path/path.dart' as path;

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  PhoneNumber number = PhoneNumber(dialCode: "+91", isoCode: "IN");
  PhoneNumber mobileNumber = PhoneNumber();
  String dropdownValue = 'HR';
  XFile? storeImage;
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 13),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Enter your name",
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xff969696),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xff969696),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.red.shade300),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.red.shade900),
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 18.0, right: 13),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(25))),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber value) {
                  mobileNumber = value;
                },
                maxLength: 10,
                initialValue: number,
                cursorColor: Colors.black,
                formatInput: false,
                selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                inputDecoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 15, left: 0),
                  border: InputBorder.none,
                  hintText: '9999999999',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 13),
              child: TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                    hintText: "Enter your age",
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xff969696),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xff969696),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.red.shade300),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.red.shade900),
                      borderRadius: BorderRadius.circular(25),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 13),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  items: <String>['HR', 'Finance', 'Marketing', 'HouseKeeping']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            (storeImage != null)
                ? ClipRect(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.height * 0.11,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Image.file(
                        File(storeImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.upload,
                    size: 50,
                  ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              textcolor: Colors.black,
              text: 'Upload Photo',
              fsize: 16,
              onTap: () async {
                storeImage = await pickImageDialog(context);
                setState(() {});
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AppButton(
                textcolor: Colors.black,
                text: 'Save',
                fsize: 16,
                concolor: Colors.teal,
                onTap: () async {
                  if (nameController.text.isNotEmpty &&
                      mobileNumber.phoneNumber!.length > 10 &&
                      ageController.text.isNotEmpty &&
                      storeImage != null) {
                    print("success");
                    showLoader(context);
                    await addUserDetails();
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please fill all the details',
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  showLoader(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      }),
    );
  }

  hideloader() {
    Navigator.pop(context);
  }

  Future addUserDetails() async {
    FirebaseStorage storageReference = FirebaseStorage.instance;
    final task =
        await storageReference.ref(path.basename(storeImage!.path)).putFile(
              File(storeImage!.path),
            );
    final urlString = await task.ref.getDownloadURL();
    String id = FirebaseFirestore.instance.collection('users').doc().id;

    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'age': ageController.text,
      'img_url': urlString,
      'mobile_no': mobileNumber.phoneNumber,
      'name': nameController.text,
      'post': dropdownValue,
      'uuid': id
    }).then((value) {
      setState(() {
        ageController.text = "";
        nameController.text = "";
        dropdownValue = 'HR';
        storeImage = null;
        mobileNumber = number;
      });
      Fluttertoast.showToast(
        msg: 'Data Uploaded Successfully',
      );
      hideloader();
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
        msg: 'Something went wrong',
      );
      hideloader();
    });
  }

  Future<XFile?> pickImageDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload Photo',
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.maxFinite,
                child: AppButton(
                  textcolor: Colors.black,
                  text: 'Browse from gallery',
                  fsize: 16,
                  onTap: () async {
                    XFile? storeGalleryImage = await _onImageButtonPressed(
                      ImageSource.gallery,
                      context: context,
                    );
                    if(!mounted) return false;
                    Navigator.pop(context, storeGalleryImage);
                  },
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }

  Future<XFile?> _onImageButtonPressed(
    ImageSource source, {
    BuildContext? context,
  }) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    return pickedFile;
  }
}
