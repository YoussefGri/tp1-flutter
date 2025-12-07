import 'package:flutter/material.dart';
import '../widgets/avatar_widget.dart';
import '../widgets/info_card_widget.dart';


class ProfileHomePage extends StatelessWidget {
  const ProfileHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Home Page"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: const <Widget>[
            // La carte d'infos
            InfoCardWidget(
              name: "Grari Youssef",
              email: "youssef.grari@etu.umontpellier.fr",
              instagramUrl: "https://www.instagram.com/grarii_youssef/?hl=fr",
            ),
            // L'avatar
            AvatarWidget(
              imagePath: "assets/images/avatar.png",
              size: 110.0,
            ),
          ],
        ),
      ),
    );
  }
}