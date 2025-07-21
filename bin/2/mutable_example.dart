class PlayerId {
  int id = 0;
  List<String> playerNames = [];
  String name = '';
  String rank = '';
  String job = '';

  void addPlayerid(int id) {
    this.id = id;
  }

  void addPlayer(String name) {
    playerNames.add(name);
  }

  void setRank(String rank) {
    this.rank = rank;
  }

  void setJob(String job) {
    this.job = job;
  }

  @override
  String toString() {
    return 'PlayerId(id: $id, playerNames: $playerNames, rank: $rank, job: $job)';
  }
}

void main() {
  final playerId = PlayerId();
  playerId.addPlayerid(123);
  playerId.addPlayer('Hero');
  playerId.setRank('Gold');
  playerId.setJob('Warrior');

  print(playerId); // PlayerId(id: 123, playerNames: [Hero], rank: Gold, job: Warrior)

  playerId.addPlayer('Super Hero');
  playerId.setRank('Platinum');

  print(playerId); // PlayerId(id: 123, playerNames: [Hero, Super Hero], rank: Platinum, job: Warrior)
}