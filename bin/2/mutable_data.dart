class GameState {
  List enemies = [];
  
  void addEnemy(Enemy enemy) {
    enemies.add(enemy); // Mengubah existing list
  }
}

class Enemy {
}

void main() {
  GameState gameState = GameState();
  gameState.addEnemy(Enemy());
  print('Number of enemies: ${gameState.enemies.length}');
}