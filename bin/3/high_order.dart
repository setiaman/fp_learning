class Vector2 {
  final double x;
  final double y;

  const Vector2(this.x, this.y);

  Vector2  copyWith({double? x, double? y}) {
    return Vector2(x ?? this.x, y ?? this.y);
  }

  @override
  String toString() => 'Vector2(x: ${x.toStringAsFixed(1)}, y: ${y.toStringAsFixed(1)})';

  @override
  bool operator ==(Object other) => 
      identical(this, other) ||
      other is Vector2 &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

class Player {
  final String name;
  final int health;
  final Vector2 position;
  const Player({
    required this.name,
    required this.health,
    required this.position,
  });

  Player copyWith({
    String? name,
    int? health,
    Vector2? position,
  }) {
    return Player(
      name: name ?? this.name,
      health: health ?? this.health,
      position: position ?? this.position,
    );
  }

  @override
  String toString() {
    return 'Player(name: $name, health: $health, position: $position)';
  }
}

T updateEntity<T>(T entity, T Function(T) updater) {
  print('  Applying update via entity: $entity');
  return updater(entity);
}

typedef FuncTransformer<T> = T Function(T value);

FuncTransformer<T> compose<T>(List<FuncTransformer<T>> functions) {
  return (T input) {
    dynamic result = input;
    print('  Creating updater for entity: $input');
    for (var func in functions) {
      result = func(result);
    }
    return result as T;
  };
}

Player validateBoundaries(Player player) {
  print(' [Transformer] Validating boundaries...');
  final minX = 0.0;
  final maxX = 100.0;
  final minY = 0.0;
  final maxY = 100.0;

  double newX = player.position.x;
  double newY = player.position.y;

  if (newX < minX) newX = minX;
  if (newX > maxX) newX = maxX;
  if (newY < minY) newY = minY;
  if (newY > maxY) newY = maxY;

  if (newX != player.position.x || newY != player.position.y) {
    return player.copyWith(position: player.position.copyWith(x: newX, y: newY));
  }
  return player;
}

Player applyPhysics(Player player) {
  print(' [Transformer] Applying physics...');
  final gravityEffect = 2.0;
  final windEffect = 0.5;
  return player.copyWith(
    position: player.position.copyWith(
      y: player.position.y - gravityEffect,
      x: player.position.x + windEffect,
    ),
  );
}

Player updateAnimation(Player player) {
  print(' [Transformer] Updating animation state (conceptual)...');
  return player;
}

void main() {
  final initialPlayer = Player(
    name: 'Hero',
    health: 100,
    position: Vector2(50.0, 50.0),
  );
  print('Initial Player: $initialPlayer\n');

  print('--- Menggunakan updateEntity untuk menambah health ---');
  final playerAfterHealthUpdate = updateEntity(
    initialPlayer,
    (player) => player.copyWith(health: player.health + 20),
  );
  print('Player after health update: $playerAfterHealthUpdate\n');

  print('--- Menggunakan updateEntity untuk mengupdate posisi ---');
  final playerAfterPositionUpdate = updateEntity(
    playerAfterHealthUpdate,
    (player) => player.copyWith(
      position: player.position.copyWith(x: 60.0, y: 40.0)),
  );
  print('Player after position update: $playerAfterPositionUpdate\n');

  print('--- Menggunakan updateEntity dengan fungsi komposisi (processPlayer) ---');
  final processPlayer = compose<Player>([
    validateBoundaries,
    applyPhysics,
    updateAnimation,
  ]);
  final playerToProcess = Player(
    name: 'Falling Guy',
    health: 80,
    position: Vector2(50.0, 50.0),
  );
  print('Player after processing: $playerToProcess\n');
  final processedPlayer = processPlayer(playerToProcess);
  print('\n--- Processed Player: $processedPlayer');
  print('\n--- Contoh lain dengan batas X---');
  final playerNearBoundary = Player(
    name: 'Wall Hugger',
    health: 90,
    position: Vector2(95.0, 50.0),
  );
  print('Player near boundary: $playerNearBoundary\n');
  final processedPlayer2 = processPlayer(playerNearBoundary);
  print('\n--- Processed Player Near Boundary: $processedPlayer2');
}