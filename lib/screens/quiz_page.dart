import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key}) : super(key: key);

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  // --- VARIABLES D'ÉTAT ---
  int _currentIndex = 0;
  int _score = 0;

  final List<Question> _questions = [
    Question(questionText: "La France a dû céder l'Alsace et la Moselle à l'Allemagne après la guerre de 1870-1871.", isCorrect: true),
    Question(questionText: "Le Mont Saint-Michel est en Normandie.", isCorrect: true),
    Question(questionText: "Paris est traversée par la Garonne.", isCorrect: false),
    Question(questionText: "Le drapeau français est Bleu, Blanc, Rouge.", isCorrect: true),
  ];

  // --- LOGIQUE ---

  void _checkAnswer(bool userChoice) {
    final isCorrect = _questions[_currentIndex].isCorrect == userChoice;

    setState(() {
      if (isCorrect) {
        _score++;
      }
    });

    // Feedback visuel (SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        isCorrect ? "Exact ! (+1 point)" : "Faux !",
        textAlign: TextAlign.center,
      ),
      backgroundColor: isCorrect ? Colors.green : Colors.red,
      duration: const Duration(milliseconds: 500),
      behavior: SnackBarBehavior.floating,
      width: 200,
    ));

    // Délai pour laisser le temps de lire avant la question suivante
    Future.delayed(const Duration(milliseconds: 500), () {
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex++;
      // Note : On ne remet pas à 0 ici, on laisse l'index dépasser
      // pour déclencher l'écran de fin dans la méthode build()
    });
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _currentIndex = 0;
    });
  }

  void _goToMainMenu() {
    // Navigator.pop permet de revenir à l'écran précédent (le menu)
    // sans empiler une nouvelle page par-dessus.
    Navigator.of(context).pop();
  }

  // --- INTERFACE ---

  @override
  Widget build(BuildContext context) {
    // Vérification : est-ce la fin du jeu ?
    bool isFinished = _currentIndex >= _questions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Affiche le score en temps réel en haut à droite
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text(
                "Score: $_score",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blueAccent],
          ),
        ),
        // Si fini -> Ecran Résultat, Sinon -> Ecran Question
        child: isFinished ? _buildResultScreen() : _buildQuizScreen(),
      ),
    );
  }

  // --- WIDGET : ÉCRAN QUESTION ---
  Widget _buildQuizScreen() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Question ${_currentIndex + 1} / ${_questions.length}",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                "assets/images/france_flag.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white30),
              ),
              child: Center(
                child: Text(
                  _questions[_currentIndex].questionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              _buildButton(true, "VRAI", Colors.greenAccent),
              const SizedBox(width: 20),
              _buildButton(false, "FAUX", Colors.redAccent),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildButton(bool choice, String label, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => _checkAnswer(choice),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(label, style: const TextStyle(color: Colors.black87, fontSize: 18)),
      ),
    );
  }

  // --- WIDGET : ÉCRAN RÉSULTAT (WIN / LOSE) ---
  Widget _buildResultScreen() {
    // Logique de victoire : Score > Moyenne
    bool isVictory = _score > (_questions.length / 2);

    // Définition des éléments selon le résultat
    String title = isVictory ? "Victoire !" : "Défaite...";
    String message = isVictory
        ? "Bravo, vous êtes un expert !"
        : "Aïe, révisez encore un peu.";
    IconData icon = isVictory ? Icons.emoji_events : Icons.sentiment_very_dissatisfied;
    Color color = isVictory ? Colors.yellowAccent : Colors.redAccent;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animation simple : ScaleTransition (Zoom In)
            TweenAnimationBuilder(
              duration: const Duration(seconds: 1),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.elasticOut, // Effet de rebond
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(icon, size: 100, color: color),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                  color: color, fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Score final : $_score / ${_questions.length}",
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 50),

            // BOUTON REJOUER
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _resetQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text("Rejouer"),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent
                ),
              ),
            ),
            const SizedBox(height: 15),

            // BOUTON MENU PRINCIPAL
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _goToMainMenu,
                icon: const Icon(Icons.home),
                label: const Text("Retour au Menu"),
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    side: const BorderSide(color: Colors.white),
                    foregroundColor: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}