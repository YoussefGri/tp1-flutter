import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoCardWidget extends StatelessWidget {
  final String name;
  final String email;
  final String instagramUrl;

  const InfoCardWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.instagramUrl,
  }) : super(key: key);

  // Fonction pour ouvrir le lien
  Future<void> _launchInstagram() async {
    final Uri url = Uri.parse(instagramUrl);

    // Tente d'ouvrir le lien (dans l'app ou le navigateur)
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Impossible d\'ouvrir le lien $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      width: 300,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Text(
            name,
            style: const TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            email,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 15),

          // InkWell permet de rendre n'importe quoi cliquable
          InkWell(
            onTap: _launchInstagram, // Appel de la fonction au clic
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Prend juste la place nécessaire
                children: const [
                  // Petite icône (Optionnel)
                  Icon(Icons.camera_alt, color: Colors.pinkAccent, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Suivez-moi sur Instagram",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}