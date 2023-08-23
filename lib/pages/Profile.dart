import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/model/user.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({required this.user});
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff273746),
      // 273746 dark
      // E59866 orange
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  tooltip: "Back",
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xffE59866),
                    size: 40,
                  ),
                  onPressed: () => Navigator.pop(context)),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.image),
                  minRadius: 30,
                  maxRadius: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                user.username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff2f2f2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                user.email,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff2f2f2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 20, left: 100, bottom: 10),
                  child: Text(
                    "Level:  ${user.level.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff2f2f2),
                    ),
                  ),
                ),
              ),
                Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 20, right: 100, bottom: 10),
                  child: Text(
                    "Wallet:  ${user.wallet.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff2f2f2),
                    ),
                  ),
                ),
                ),
              ],
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 300,
                  width: 300,
                  color: Colors.black45,
                  child: Column(
                    children: [
                      const Align(
                        child: Text(
                          "Projects",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: user.projects.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                user.projects[index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: Padding(
                                padding: EdgeInsets.only(left: 0),
                                child: Wrap(
                                  children: [
                                    if (user.projects[index].validated == true)
                                      Text(
                                        "${user.projects[index].note}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    else if (user.projects[index].inProgress ==
                                        true)
                                      Icon(
                                        Icons.loop,
                                        color: Colors.orange,
                                      )
                                    else
                                      Icon(Icons.close, color: Colors.red)
                                  ],
                                  // "${user.projects[index].note}",
                                  // style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => Container(
                            height: 1,
                            color: Colors.white24,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: 300,
                  height: 200,
                  color: Colors.black45,
                  child: Column(
                    children: [
                      const Align(
                        child: Text(
                          "Skills",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: user.skills.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              title: Text(
                                user.skills[index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: Text(
                                "${user.skills[index].score}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => Container(
                            height: 1,
                            color: Colors.white24,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
