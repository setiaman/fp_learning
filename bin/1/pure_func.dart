int addScore(int currentScore, int points) {
  return currentScore + points;
}
final newScore = addScore(100, 50);

void main() {
  print('Score: $newScore');
}