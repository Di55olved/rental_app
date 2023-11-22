import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_app/Apis/api.dart';
import 'package:rental_app/Auth/sign_in.dart';
import 'package:rental_app/Model/misc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController displayNameController = TextEditingController();
  TextEditingController profilePicController = TextEditingController();

  void showPopup(BuildContext context, MiscAttributesMethods obj) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit Profile"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: displayNameController,
                      decoration: const InputDecoration(
                          label: Text("Enter Display Name: "),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 116, 80, 3))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 116, 80, 3)))),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: profilePicController,
                      decoration: const InputDecoration(
                          label: Text("Enter Profile Picture URL: "),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 116, 80, 3))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 116, 80, 3)))),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          obj.setDisplayName(displayNameController.text);
                          obj.setPhotoURL(profilePicController.text);
                          await Api.firestore
                              .collection('users')
                              .doc(Api.auth.currentUser!.uid)
                              .set(obj.userData);

                          Navigator.pop(context);
                        },
                        child: const Text("Submit")),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MiscAttributesMethods>(
      builder: (context, obj, child) => Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/iRent_brown.png',
            width: 100.0,
            height: 100.0,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        drawer: Drawer(
            backgroundColor: const Color.fromARGB(255, 255, 193, 61),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: NetworkImage(
                                    obj.userData['image'].toString() == 'null'
                                        ? "https://picsum.photos/200/300?grayscale"
                                        : obj.userData['image'].toString(),
                                  ),
                                  backgroundColor: Colors
                                      .transparent, // Set background color to transparent
                                  foregroundColor: Colors
                                      .transparent, // Set foreground color to transparent
                                ),
                                const SizedBox(
                                  width: 25.0,
                                ),
                                Text(
                                  obj.userData['name'].toString() == 'null'
                                      ? "Edit Name"
                                      : obj.userData['name'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0,
                                      color: Color.fromARGB(255, 94, 64, 0),
                                      fontStyle: FontStyle.italic),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(obj.userData['email'].toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 94, 64, 0),
                                  fontStyle: FontStyle.normal)),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text("Status: ${obj.userData['status'].toString()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: obj.userData['status'].toString() ==
                                          'Active'
                                      ? Colors.lightGreenAccent.shade200
                                      : const Color.fromARGB(255, 94, 64, 0),
                                  fontStyle: FontStyle.normal)),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text("Strikes: ${obj.userData['strikes'].toString()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 94, 64, 0),
                                  fontStyle: FontStyle.normal)),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1.0,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ListTile(
                            title: const Text(
                              "Edit Profile",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            leading: const Icon(Icons.edit),
                            onTap: () {
                              showPopup(context, obj);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ListTile(
                            title: const Text(
                              "Rented Items",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            leading: const Icon(Icons.car_rental_rounded),
                            onTap: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ListTile(
                            title: const Text(
                              "My Products",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            leading: const Icon(Icons.view_list),
                            onTap: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          )
                        ],
                      )
                    ],
                  )),
                  Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Column(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 116, 80, 3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              onPressed: () {
                                Api.auth.signOut();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInPage()));
                              },
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.2,
                                child: const Row(
                                  children: [
                                    Icon(Icons.logout),
                                    Text("Sign Out"),
                                  ],
                                ),
                              ))
                        ],
                      ))
                ],
              ),
            )),
        body: ListView(
          children: [
            ElevatedButton(
                onPressed: () {
                  log(obj.userData.toString());
                },
                child: const Text("data"))
          ],
        ),
      ),
    );
  }
}
