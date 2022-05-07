import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class viewdata extends StatefulWidget {
  const viewdata({Key? key}) : super(key: key);

  @override
  State<viewdata> createState() => _viewdataState();
}

class _viewdataState extends State<viewdata> {
  List temp = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getalldata();
  }

  Future<void> getalldata() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("RealTime");

    DatabaseEvent de = await ref.once();

    print("${de.snapshot.value}");

    Map map = de.snapshot.value as Map;

    map.forEach((key, hh) {
      setState(() {
        temp.add(hh);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: GridView.builder(
            itemCount: temp.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 20,
                  child: Container(
                    height: 100,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(shape: BoxShape.circle),
                                child: Image.network("${temp[index]['imageurl']}"))),
                        Expanded(
                            child: Row(
                              children: [
                                Text("${temp[index]['name']}"),
                                PopupMenuButton(
                                  onSelected: (value) async {
                                    print("rjofficial");

                                    if(value==0)
                                    {
                                      DatabaseReference ref = FirebaseDatabase.instance
                                          .ref("RealTime")
                                          .child(temp[index]['id']);

                                      String? id = ref.key;

                                      await ref.set({
                                        "id": id,
                                        "name": "updatename",
                                        "imageurl":
                                        "https://play-lh.googleusercontent.com/k7fkKToy39BLJ_u2U06lSRQDbl2_gK-Cdfl4SKmHPkVvXV09z3zvejQ8c1kSEPwMrDI=s180-rw"
                                      });

                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context) {
                                          return viewdata();
                                        },
                                      ));
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                          onTap: () async {},
                                          value: 0,
                                          child: Text("Update")),
                                      PopupMenuItem(value: 1, child: Text("Delete"))
                                    ];
                                  },
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            },
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          )),
    );
  }
}