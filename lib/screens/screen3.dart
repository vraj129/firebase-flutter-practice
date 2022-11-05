import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Screen3 extends StatefulWidget {
  String docId;

  Screen3({Key? key, required this.docId}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("User Data"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(widget.docId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!['img_url']),
                      backgroundColor: const Color(0xffFDF100),
                      radius: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!["name"].toString(),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Age :  ${snapshot.data!["age"].toString()}",
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Mobile :  ${snapshot.data!["mobile_no"].toString()}",
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Department :  ${snapshot.data!["post"].toString()}",
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
