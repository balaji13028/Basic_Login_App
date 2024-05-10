import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devpoint_solutions/models/userprofile_data.dart';
import 'package:devpoint_solutions/provider/firestore_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logoutMethod() {
    context.read<FireStoreProvider>().logout(context);
  }

  @override
  Widget build(BuildContext context) {
    UserProfileData user = Provider.of<FireStoreProvider>(context).user;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home Page'),
          actions: [
            IconButton(
                onPressed: () async {
                  logoutMethod();
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('email',
                    isEqualTo: Provider.of<FireStoreProvider>(context)
                        .loginDetails!
                        .email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return const SizedBox(
                  child: Center(child: Text("No user founded")),
                );
              } else if (snapshot.hasData) {
                user =
                    UserProfileData.fromMap(snapshot.data!.docs.first.data());
              }
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: CircleAvatar(
                        radius: 85,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.asset('assets/unisex.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Name',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          )),
                      subtitle: Text(user.name.toString()),
                      subtitleTextStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.mail),
                      title: const Text('Email',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          )),
                      subtitle: Text(user.email.toString()),
                      subtitleTextStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        user.gender == 'Male' ? Icons.male : Icons.female,
                      ),
                      title: const Text('Gender',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          )),
                      subtitle: Text(user.gender.toString()),
                      subtitleTextStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
