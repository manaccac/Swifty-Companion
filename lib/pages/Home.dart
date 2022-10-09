// ignore: use_key_in_widget_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_cubit.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final Repository repository;
  // _MyHomePageState({required this.oauthService});
  // final user = await repository.fetchUser42("manaccac");

  int _counter = 0;
  String _pseudo = "";
  bool _find = false;
  bool _error = false;

  bool _searchButtonDisabled = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _searchUser(String username) {
    // BlocProvider.of<ProfileCubit>.fetchUserProfile("manaccac");
    print("hello");
    if (username == "")
      print("error");
    else
      BlocProvider.of<ProfileCubit>(context).fetchUserProfile(username);
    setState(() {
      _find = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        setState(() {
          _find = false;
        });
        if (state is ProfileLoaded) {
          print("LOADED");
          print(state.user.email);
          Navigator.pushNamed(context, "/profile", arguments: state.user);
        }
        if (state is ProfileError) {
          setState(() {
            _error = true;
          });
          print("FAIL");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade900,
                title: const Align(
                  child: Text(
                    "Error",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                actions: [
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          _error = false;
                          // _pseudo = "";
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "X",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              );
            },
          );
        }
        setState(() {
          _find = false;
        });
        if (_find == true) {
          Text("YES");
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff273746),
        body: Container(
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 100),
                  child: Text(
                    "Swifty companion",
                    style: TextStyle(
                      color: Color(0xffE59866),
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    style: TextStyle(color: Color(0xffE59866)),
                    onChanged: (value) {
                      _pseudo = value;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter a username",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xfff2f2f2),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      _searchUser(_pseudo);
                    },
                    child: const Text(
                      'Search',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
