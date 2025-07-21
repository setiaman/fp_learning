class Player {
  int health;
  bool isAlive;
  Player(this.health, {this.isAlive = true});

  Player copyWith({int? health, bool? isAlive}) {
    return Player(
      health ?? this.health,
      isAlive: isAlive ?? this.isAlive,
    );
  }
}

Player updatePlayerHealth(Player player, int damage) {
  final newHealth = player.health - damage;
  final actualDamage = player.health - newHealth;
  print('Player took $actualDamage damage');
  return player.copyWith(
    health: newHealth,
    isAlive: newHealth > 0,
  );
}

void main() {
  Player player = Player(100);
  var damagedPlayer = updatePlayerHealth(player, 25);
  print('Health remaining: ${damagedPlayer.health}'); // 75
  print('Is alive: ${damagedPlayer.isAlive}'); // true

  damagedPlayer = updatePlayerHealth(damagedPlayer, 15);
  print('Health after second damage: ${damagedPlayer.health}'); // 60
  print('Is alive: ${damagedPlayer.isAlive}'); // true

  damagedPlayer = updatePlayerHealth(damagedPlayer, 45);
  print('Health after second damage: ${damagedPlayer.health}');
  print('Is alive: ${damagedPlayer.isAlive}');

  damagedPlayer = updatePlayerHealth(damagedPlayer, 20);
  print('Final health: ${damagedPlayer.health}');
  print('Is alive: ${damagedPlayer.isAlive}');
}

