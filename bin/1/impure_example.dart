class Player {
  int health;
  bool isAlive = true;
  Player(this.health);
}

void updatePlayerHealth(Player player,int damage) {
  player.health -= damage;
  if (player.health <= 0) {
    player.isAlive = false; // Mark player as dead
    player.health = 0; // Ensure health doesn't go below zero
  } else {

  }
}

void main() {
  Player player = Player(100);
  print('Initial Health: ${player.health}');

  updatePlayerHealth(player, 30);
  print('Health after damage: ${player.health}');

  updatePlayerHealth(player, 80);
  print('Health after damage: ${player.health}');
}

