class GameState {
  int frameCount;
  String inputState;
  double physicsTime;
  List<String> activeCollisions;
  String animationState;
  List<String> deadEntities;

  GameState({
    this.frameCount = 0,
    this.inputState = '',
    this.physicsTime = 0.0,
    this.activeCollisions = const [],
    this.animationState = '',
    this.deadEntities = const [],
  });

  @override
  String toString() {
    return 'GameState(frameCount: $frameCount, inputState: $inputState, physicsState: $physicsTime, activeCollisions: $activeCollisions, animationState: $animationState, deadEntities: $deadEntities)';
  }
}

typedef GameStateTransformer = GameState Function(GameState state);

GameState handleInput(GameState state) {
  print('Handling input: ${state.inputState}');
  return GameState(
    frameCount: state.frameCount,
    inputState: 'Input inserted',
    physicsTime: state.physicsTime,
    activeCollisions: state.activeCollisions,
    animationState: state.animationState,
    deadEntities: state.deadEntities,
  );
}

GameState updatePhysics(GameState state) {
  print('Updating physics for frame ${state.frameCount}');
  return GameState(
    frameCount: state.frameCount + 1,
    inputState: state.inputState,
    physicsTime: state.physicsTime + 0.016, // Assuming 60 FPS
    activeCollisions: state.activeCollisions,
    animationState: state.animationState,
    deadEntities: state.deadEntities,
  );
}

GameState checkCollisions(GameState state) {
  print('Checking collisions for frame ${state.frameCount}');
  // Simulate collision detection
  List<String> newCollisions = ['Collision1', 'Collision2'];
  return GameState(
    frameCount: state.frameCount,
    inputState: state.inputState,
    physicsTime: state.physicsTime,
    activeCollisions: ['player_enemy_collision'] + newCollisions,
    animationState: state.animationState,
    deadEntities: state.deadEntities,
  );
}

GameState updateAnimations(GameState state) {
  print('Updating animations for frame ${state.frameCount}');
  return GameState(
    frameCount: state.frameCount,
    inputState: state.inputState,
    physicsTime: state.physicsTime,
    activeCollisions: state.activeCollisions,
    animationState: 'Animation updated',
    deadEntities: state.deadEntities,
  );
}

GameState cleanUpDeadEntities(GameState state) {
  print('Cleaning up dead entities for frame ${state.frameCount}');
  return GameState(
    frameCount: state.frameCount,
    inputState: state.inputState,
    physicsTime: state.physicsTime,
    activeCollisions: state.activeCollisions,
    animationState: state.animationState,
    deadEntities: ['Entity1', 'Entity2'],
  );
}

extension Pipeline<T> on T {
  R pipe<R>(R Function(T) transform) => transform(this);
}

Function compose<A, B, C>(Function f, Function g) {
  return (A a) {
    return f(g(a));
  };
}

GameStateTransformer composeGameStateTransformers(
  GameStateTransformer f,
  GameStateTransformer g,
) {
  return (GameState state) => f(g(state));
}

void main() {
  print('--- Memulai Game Loop Pipeline ---');
  GameState initialState = GameState();
  print('Initial State: $initialState');

  GameState finalState = initialState
      .pipe(handleInput)
      .pipe(updatePhysics)
      .pipe(checkCollisions)
      .pipe(updateAnimations)
      .pipe(cleanUpDeadEntities);

  print('Final State: $finalState');
  print('--- Game Loop Pipeline Selesai ---');

  final updatePhysicsAndCheckCollisions  = composeGameStateTransformers(
    updatePhysics,
    checkCollisions,
  );

  final preRenderPipeline = composeGameStateTransformers(
    updateAnimations,
    cleanUpDeadEntities,
  );

  final fullPipelineStep = composeGameStateTransformers(
    cleanUpDeadEntities,
    preRenderPipeline,
  );

print('\nState setelah menjalankan komposisi (updatePhysics dan checkCollisions):');
GameState composedState = initialState
    .pipe(handleInput)
    .pipe(updatePhysicsAndCheckCollisions)
    .pipe(cleanUpDeadEntities);
  print('Composed State (partial): $composedState');

  print('\nState setelah menjalankan komposisi lengkap (contoh):');
  GameState fullyComposedState = initialState.pipe(handleInput).pipe(fullPipelineStep);
  print('Composed State (full): $fullyComposedState');
}