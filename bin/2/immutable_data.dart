class GameState {
  final List enemies;
  const GameState({required this.enemies});

  GameState addEnemy(Enemy enemy) {
    // Mengembalikan instance baru dengan list yang diperbarui
    return GameState(enemies: [...enemies, enemy]);
  }
}

class Enemy {
}

void main() {
  GameState gameState = GameState(enemies: []);
  gameState = gameState.addEnemy(Enemy());
  print('Number of enemies: ${gameState.enemies.length}');
}