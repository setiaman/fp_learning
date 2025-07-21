T updateEntity(T entity, T Function(T) updater) {
  return updater(entity);
}

final updatedPlayer = updateEntity(player, (p) => p.copyWith(health: p.health + 10));

final processPlayer = compose([
  validateBoundaries,
  applyPhysics,
  updateAnimation,
  ]);