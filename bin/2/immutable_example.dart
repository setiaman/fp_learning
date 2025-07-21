class PlayerId {
  final String id;
  final String name;
  final String rank;
  final String job;

  const PlayerId({
    required this.id,
    required this.name,
    required this.rank,
    required this.job,
  });

  PlayerId copyWith({
    required PlayerId playerId,
    String? id,
    String? name,
    String? rank,
    String? job,
  }) {
    return PlayerId(
      id: id ?? playerId.id,
      name: name ?? playerId.name,
      rank: rank ?? playerId.rank,
      job: job ?? playerId.job,
    );
  }

  @override
  String toString() {
    return 'PlayerId(id: $id, name: $name, rank: $rank, job: $job)';
  }
}

void main() {
  final playerId = PlayerId(
    id: '123',
    name: 'Hero',
    rank: 'Gold',
    job: 'Warrior',
  );

  print(playerId); // PlayerId(id: 123, name: Hero, rank: Gold, job: Warrior)

  final updatedPlayerId = playerId.copyWith(
    playerId: playerId,
    name: 'Super Hero',
    rank: 'Platinum',
  );

  print(updatedPlayerId); // PlayerId(id: 123, name: Super Hero, rank: Platinum, job: Warrior)
}
