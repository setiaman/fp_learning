class Enemy {
  double x;
  double y;
  int health;
  String behavior;

  Enemy({
    required this.x,
    required this.y,
    this.health = 100,
    this.behavior = 'idle',
  });

  @override
  String toString() {
    return 'Enemy(x: $x, y: $y, health: $health, behavior: $behavior)';
  }
}

typedef EnemyTransformer = Enemy Function(Enemy enemy);

Enemy moveEnemy(Enemy enemy, double deltaTime) {
  // Example movement logic
  return Enemy(
    x: enemy.x + 10 * deltaTime,
    y: enemy.y,
    health: enemy.health,
    behavior: enemy.behavior,
  );
}

Enemy updateEnemyAI(Enemy enemy) {
  // Example AI logic
  if (enemy.health < 50) {
    return Enemy(
      x: enemy.x,
      y: enemy.y,
      health: enemy.health,
      behavior: 'retreat',
    );
  } else {
    return Enemy(
      x: enemy.x,
      y: enemy.y,
      health: enemy.health,
      behavior: 'attack',
    );
  }
}

Enemy checkEnemyCollisions(Enemy enemy) {
  final newHealth = enemy.health - 5;
  return Enemy(x: enemy.x, y: enemy.y, health: newHealth, behavior: enemy.behavior);
}

List<Enemy> updateEnemies(
  List<Enemy> enemies,
  List<EnemyTransformer> transformers,
) {
  return enemies.map((enemy) {
    return transformers.fold(enemy, (currentEnemy, transformer) {
      return transformer(currentEnemy);
    });
  }).toList();
}

void main() {
  List<Enemy> enemies = [
    Enemy(x: 0, y: 0, health: 100, behavior: 'attack'),
    Enemy(x: 10, y: 5, health: 40, behavior: 'idle'),
    Enemy(x: 20, y: 10, health: 80, behavior: 'patrol'),
  ];

  print('Musuh Awal:');
  enemies.forEach(print);

  double deltaTime = 0.1;

  final List<EnemyTransformer> enemyTransformers = [
    (enemy) => moveEnemy(enemy, deltaTime),
    (enemy) => updateEnemyAI(enemy),
    (enemy) => checkEnemyCollisions(enemy),
  ];

  final updatedEnemies = updateEnemies(enemies, enemyTransformers);

  print('\nMusuh Setelah Update:');
  updatedEnemies.forEach(print);

  print('\nMemperbarui musuh dengan fungsi yang berbeda: (AI terakhir )');

  final updatedEnemies2 = updateEnemies(enemies, [
    (enemy) => moveEnemy(enemy, deltaTime),
    (enemy) => updateEnemyAI(enemy),
    (enemy) => checkEnemyCollisions(enemy),
  ]);
  updatedEnemies2.forEach(print);
}