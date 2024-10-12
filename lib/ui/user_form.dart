import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/const/AppColors.dart';
import 'package:e_commerce_app/ui/bottom_nav_controller.dart';
import 'package:e_commerce_app/widgets/customButton.dart';
import 'package:e_commerce_app/widgets/myTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "name": _nameController.text,
          "phone": _phoneController.text,
          "dob": _dobController.text,
          "gender": _genderController.text,
          "age": _ageController.text,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => BottomNavController())))
        .catchError((error) => print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Submit the form to continue.",
                  style:
                      TextStyle(fontSize: 22.sp, color: AppColors.deep_orange),
                ),
                Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                myTextField(
                    "Enter your name", TextInputType.text, _nameController),

                // myTextField("Enter your phone number", TextInputType.number,
                //     _phoneController),

                IntlPhoneField(
                  decoration: InputDecoration(
                      // labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 0)),
                      
                  initialCountryCode: 'US',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),

                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Date of Birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                // TextField(
                //   controller: _genderController,
                //   readOnly: true,
                //   decoration: InputDecoration(
                //     hintText: "Gender",
                //     suffixIcon: DropdownButton<String>(
                //       icon: Icon(Icons.arrow_drop_down),
                //       underline: SizedBox(),
                //       items: gender.map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //           onTap: () {
                //             setState(() {
                //               _genderController.text = value;
                //             });
                //           },
                //         );
                //       }).toList(),
                //       onChanged: (String? newValue) {
                //         _genderController.text = newValue!;
                //       },
                //     ),
                //   ),
                // ),
                GestureDetector(
                  onTap: () async {
                    String? selectedGender = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Select Gender'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: gender.map((String value) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context, value);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    );

                    if (selectedGender != null) {
                      setState(() {
                        _genderController.text = selectedGender;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _genderController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Gender',
                        suffixIcon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                  ),
                ),

                myTextField(
                    "Enter your age", TextInputType.number, _ageController),

                SizedBox(
                  height: 50.h,
                ),

                // elevated button
                customButton("Continue", () => sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
