import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pineapp/screens/screen3.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.size == 0) {
            return const Center(child: Text("No User data"));
          }
          return ListView(
            children: getUserData(snapshot),
          );
        });
  }

  getUserData(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs.map((doc) {
      return GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  Screen3(
              docId: doc["uuid"],
            )),
          );
        },
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(doc['img_url']),
                  backgroundColor: const Color(0xffFDF100),
                  radius: 30,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "${doc["name"]}",
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),

              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
