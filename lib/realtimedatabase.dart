import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profire/realtimeviewdata.dart';

class RealtimeDB extends StatefulWidget {
  const RealtimeDB({Key? key}) : super(key: key);

  @override
  State<RealtimeDB> createState() => _RealtimeDBState();
}

class _RealtimeDBState extends State<RealtimeDB> {
  String imhg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    // Pick an image
                    final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      imhg = image!.path;
                    });
                  },
                  child: Container(
                    height: 400,
                    child: imhg != ""
                        ? CircleAvatar(


                      radius: 100,
                      backgroundImage: FileImage(File(imhg)),
                    )
                        : CircleAvatar(
                      backgroundImage: FileImage(File("")),
                    ),
                  ),
                ),
              ),
              FlatButton(
                  minWidth: 150,
                  height: 50,
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    // side: BorderSide(color: Colors.black, width: 2)
                  ),
                  onPressed: () async {
                    final storageRef = FirebaseStorage.instance.ref();

                    DateTime mm = DateTime.now();

                    String ctime = "${mm.second}";

                    String imagename = "Jatin${ctime}.jpg";

                    final spaceRef = storageRef.child("CDMI/$imagename");

                    await spaceRef.putFile(File(imhg));

                    spaceRef.getDownloadURL().then((value) async {
                      print(value);

                      DatabaseReference ref =
                      FirebaseDatabase.instance.ref("RealTime").push();
                      String? id = ref.key;

                      await ref
                          .set({"name": "rj", "id": id, "imageurl": value});

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return viewdata();
                      },));

                    });
                  },
                  child: Text("Send Image"))
            ],
          ),
        ),
      ),
    );
  }
}
