class Player {
  int score = 0;
  void addScore(int points) {
    score += points;
  }
}

void main() {
  Player player = Player();
  player.addScore(10);
  player.addScore(20);
  print('Score: ${player.score}');
}